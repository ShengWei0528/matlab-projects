"""Re-plot signals-and-systems/audio_dft_spectrum.m as an SVG (stdlib only).

Mirrors the MATLAB script step by step:

    [s, fs] = audioread(wav);  xt = s(1:8000, 1);  N = 8000;  xf = fft(xt);
    f = fs*(0:(N/2))/N;  n = N/2 + 1;
    subplot(3,1,1) plot(xt)
    subplot(3,1,2) plot(f, abs(xf(1:n)))
    subplot(3,1,3) plot(f, 20*log10(abs(xf(1:n))))

It was used to produce assets/signals-dft-spectrum.svg for the README, so the
figure can be regenerated without MATLAB.

Usage:
    python spectrum_svg.py signals-and-systems/audio_sample.wav assets/signals-dft-spectrum.svg
"""
import cmath
import math
import struct
import sys
import wave


def read_channel1(path):
    with wave.open(path, 'rb') as w:
        nch, sw, fs, nfr = w.getnchannels(), w.getsampwidth(), w.getframerate(), w.getnframes()
        raw = w.readframes(nfr)
    if sw != 2:
        raise SystemExit('expected 16-bit PCM')
    vals = struct.unpack('<%dh' % (len(raw) // 2), raw)
    # audioread scales int16 samples to [-1, 1)
    return [vals[i] / 32768.0 for i in range(0, len(vals), nch)], fs


def fft(x):
    """Mixed-radix (2, 3, 5, 7) Cooley-Tukey FFT; N = 8000 = 2^6 * 5^3."""
    n = len(x)
    if n == 1:
        return list(x)
    for r in (2, 3, 5, 7):
        if n % r == 0:
            break
    else:  # prime length: direct DFT
        return [sum(x[k] * cmath.exp(-2j * math.pi * k * m / n) for k in range(n)) for m in range(n)]
    m = n // r
    subs = [fft(x[i::r]) for i in range(r)]
    tw = [cmath.exp(-2j * math.pi * k / n) for k in range(n)]
    return [sum(subs[i][k % m] * tw[(i * k) % n] for i in range(r)) for k in range(n)]


def nice_ticks(lo, hi, target=6):
    span = hi - lo
    if span <= 0:
        return [lo]
    p = 10 ** math.floor(math.log10(span / target))
    for mult in (1, 2, 2.5, 5, 10):
        step = mult * p
        if span / step <= target:
            break
    v = math.ceil(lo / step - 1e-9) * step
    ticks = []
    while v <= hi + 1e-9 * step:
        ticks.append(round(v, 10))
        v += step
    return ticks


def fmt(v):
    if abs(v) >= 1000 or v == int(v):
        return '%d' % round(v)
    return ('%.3f' % v).rstrip('0').rstrip('.')


def panel(x, y, ox, oy, pw, ph, title, xlab, ylab, xlim, ylim):
    ymin, ymax = ylim
    yt = nice_ticks(ymin, ymax)
    ymin, ymax = min(ymin, yt[0]), max(ymax, yt[-1])

    def px(v):
        return ox + (v - xlim[0]) / (xlim[1] - xlim[0]) * pw

    def py(v):
        return oy + ph - (v - ymin) / (ymax - ymin) * ph

    out = [f'<rect x="{ox}" y="{oy}" width="{pw}" height="{ph}" fill="#ffffff" stroke="#262626"/>']
    for t in nice_ticks(*xlim):
        out.append(f'<line x1="{px(t):.1f}" y1="{oy + ph}" x2="{px(t):.1f}" y2="{oy + ph - 5}" stroke="#262626"/>')
        out.append(f'<text x="{px(t):.1f}" y="{oy + ph + 16}" text-anchor="middle">{fmt(t)}</text>')
    for t in yt:
        out.append(f'<line x1="{ox}" y1="{py(t):.1f}" x2="{ox + 5}" y2="{py(t):.1f}" stroke="#262626"/>')
        out.append(f'<text x="{ox - 6}" y="{py(t) + 4:.1f}" text-anchor="end">{fmt(t)}</text>')
    # min/max decimation per pixel column keeps the SVG small without losing peaks
    cols = {}
    for xv, yv in zip(x, y):
        c = min(max(int((xv - xlim[0]) / (xlim[1] - xlim[0]) * pw), 0), pw)
        if c not in cols:
            cols[c] = [yv, yv, yv, yv]  # first, min, max, last
        else:
            col = cols[c]
            col[1], col[2], col[3] = min(col[1], yv), max(col[2], yv), yv
    pts = []
    for c in sorted(cols):
        first, mn, mx, last = cols[c]
        for v in ([first, mn, mx, last] if mn != mx else [first]):
            pts.append(f'{ox + c:.1f},{py(min(max(v, ymin), ymax)):.1f}')
    out.append(f'<polyline fill="none" stroke="#0072BD" stroke-width="1" points="{" ".join(pts)}"/>')
    out.append(f'<text x="{ox + pw / 2}" y="{oy - 8}" text-anchor="middle" font-weight="bold">{title}</text>')
    out.append(f'<text x="{ox + pw / 2}" y="{oy + ph + 34}" text-anchor="middle">{xlab}</text>')
    out.append(f'<text transform="translate({ox - 48},{oy + ph / 2}) rotate(-90)" text-anchor="middle">{ylab}</text>')
    return '\n'.join(out)


def main(wav, svg_path):
    ch1, fs = read_channel1(wav)
    N = 8000
    xt = ch1[:N]
    X = fft([complex(v) for v in xt])
    half = N // 2 + 1
    f = [fs * k / N for k in range(half)]
    mag = [abs(X[k]) for k in range(half)]
    db = [20 * math.log10(m) if m > 0 else -300.0 for m in mag]
    dbmin = max(min(db), max(db) - 120)

    W, H, ox, pw, ph = 900, 760, 90, 780, 160
    svg = [f'<svg xmlns="http://www.w3.org/2000/svg" width="{W}" height="{H}" viewBox="0 0 {W} {H}" '
           f'font-family="Helvetica, Arial, sans-serif" font-size="12" fill="#262626">',
           f'<rect width="{W}" height="{H}" fill="#ffffff"/>',
           panel(list(range(1, N + 1)), xt, ox, 40, pw, ph,
                 'Fig. 2 (a) Time signal xt[n] vs time index n', 'n (sample index)', 'amplitude',
                 (1, N), (min(xt), max(xt))),
           panel(f, mag, ox, 290, pw, ph,
                 'Fig. 2 (b) DFT Magnitude spectrum xf vs f (Hz)', 'f (Hz)', '|xf|',
                 (0, fs / 2), (0, max(mag))),
           panel(f, db, ox, 540, pw, ph,
                 'Fig. 2 (c) DFT Magnitude Spectrum xf (dB) vs f (Hz)', 'f (Hz)', 'dB',
                 (0, fs / 2), (dbmin, max(db))),
           '</svg>']
    with open(svg_path, 'w', encoding='utf-8', newline='\n') as fh:
        fh.write('\n'.join(svg) + '\n')


if __name__ == '__main__':
    if len(sys.argv) != 3:
        sys.exit(__doc__)
    main(sys.argv[1], sys.argv[2])
