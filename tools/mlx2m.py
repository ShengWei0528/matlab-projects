"""Export the code inside MATLAB .mlx / .mlapp files to plain text.

Live Editor (.mlx) and App Designer (.mlapp) files are ZIP (Open Packaging
Convention) archives. The code lives in ``matlab/document.xml``:

* .mlx   - code paragraphs are written verbatim; text, title and heading
           paragraphs become MATLAB comments ("%%" section headers for
           titles/headings).
* .mlapp - the generated ``classdef`` code is written verbatim.

Optionally, figures and text outputs embedded in ``matlab/output.xml`` can be
extracted (figures are saved as PNG files).

Only the Python standard library is used.

Usage:
    python mlx2m.py <file.mlx|file.mlapp> <out.m> [<figure_dir> <figure_prefix>]
"""
import base64
import os
import re
import sys
import zipfile
import xml.etree.ElementTree as ET

W = '{http://schemas.openxmlformats.org/wordprocessingml/2006/main}'


def _para_text(p):
    return ''.join(n.text for n in p.iter() if n.tag == W + 't' and n.text)


def _para_style(p):
    ppr = p.find(W + 'pPr')
    st = ppr.find(W + 'pStyle') if ppr is not None else None
    return st.get(W + 'val') if st is not None else None


def convert(pkg, out):
    """Write the code of ``pkg`` to ``out`` and return it as a string."""
    with zipfile.ZipFile(pkg) as z:
        doc = z.read('matlab/document.xml').decode('utf-8')
    body = ET.fromstring(doc).find(W + 'body')
    lines = []
    for p in body.findall(W + 'p'):
        style, txt = _para_style(p), _para_text(p)
        if style == 'code':
            lines.extend(txt.replace('\r\n', '\n').split('\n'))
            lines.append('')
        elif style in ('title', 'heading'):
            if txt.strip():
                if lines and lines[-1] != '':
                    lines.append('')
                lines.append('%% ' + txt.strip())
        elif txt.strip():
            bullet = '- ' if style == 'ListParagraph' else ''
            for ln in txt.replace('\r\n', '\n').split('\n'):
                lines.append('% ' + bullet + ln.rstrip())
    res = []
    for ln in lines:  # collapse repeated blank lines
        if ln == '' and res and res[-1] == '':
            continue
        res.append(ln.rstrip())
    text = '\n'.join(res).strip('\n') + '\n'
    with open(out, 'w', encoding='utf-8', newline='\n') as f:
        f.write(text)
    return text


def extract_outputs(pkg, figdir, prefix):
    """Save embedded figures as PNG and print text outputs of an .mlx file."""
    with zipfile.ZipFile(pkg) as z:
        if 'matlab/output.xml' not in z.namelist():
            return
        data = z.read('matlab/output.xml').decode('utf-8')
    arr = ET.fromstring(data).find('outputArray')
    if arr is None:
        return
    n = 0
    for el in arr.findall('element'):
        typ, od = el.findtext('type'), el.find('outputData')
        if typ == 'figure':
            m = re.match(r'data:image/(png|jpeg);base64,(.*)', od.findtext('figureUri') or '', re.S)
            if m:
                n += 1
                os.makedirs(figdir, exist_ok=True)
                ext = 'png' if m.group(1) == 'png' else 'jpg'
                fn = os.path.join(figdir, f'{prefix}-fig{n}.{ext}')
                with open(fn, 'wb') as f:
                    f.write(base64.b64decode(m.group(2)))
                print(f'[figure {n}] -> {fn}')
        elif od is not None and od.findtext('text') is not None:
            print(f'[{typ}]\n{od.findtext("text")}')


if __name__ == '__main__':
    if len(sys.argv) not in (3, 5):
        sys.exit(__doc__)
    convert(sys.argv[1], sys.argv[2])
    if len(sys.argv) == 5:
        extract_outputs(sys.argv[1], sys.argv[3], sys.argv[4])
