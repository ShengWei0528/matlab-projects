"""Re-plot the Waveform_NOW2 app output as an SVG (Python stdlib only).

Mirrors the private method ``updatePlots(app)`` in
waveform-generator-app/Waveform_NOW2.m:

    t = linspace(0, 2*pi, 1000);
    x = ampX * cos(freqX * t + theta);      % theta = deg2rad(slider value)
    y = ampY * sin(freqY * t + theta);
    xLimit = max(10, max(abs(x)));  yLimit = max(10, max(abs(y)));
    plot(UIAxes,  t, x, 'b');  ylim([-xLimit xLimit])
    plot(UIAxes2, t, y, 'r');  ylim([-yLimit yLimit])
    plot(UIAxes3, x, y, 'g');  equal aspect, xlim/ylim = +/-xLimit, +/-yLimit

The top row shows x(t) and y(t) for one setting; the bottom row shows the XY
plot for the three phase values the assignment asks about (0, 45, 90 deg).
It was used to produce assets/waveform-lissajous-replot.svg for the README, so
the app's output can be shown without a MATLAB screenshot.

Usage:
    python lissajous_svg.py assets/waveform-lissajous-replot.svg [Ax Ay fx fy]
"""
import math
import sys

BLUE, RED, GREEN, INK = '#0000FF', '#FF0000', '#009E00', '#262626'


def update_plots(amp_x, amp_y, freq_x, freq_y, theta_deg, n=1000):
    """Same arithmetic as updatePlots(app) in Waveform_NOW2."""
    theta = math.radians(theta_deg)
    t = [2 * math.pi * k / (n - 1) for k in range(n)]
    x = [amp_x * math.cos(freq_x * v + theta) for v in t]
    y = [amp_y * math.sin(freq_y * v + theta) for v in t]
    x_max = max(abs(v) for v in x) or 1
    y_max = max(abs(v) for v in y) or 1
    return t, x, y, max(10, x_max), max(10, y_max)


def nice_ticks(lo, hi, target=5):
    span = hi - lo
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
    return '%d' % round(v) if v == int(v) else ('%.2f' % v).rstrip('0').rstrip('.')


def panel(xs, ys, ox, oy, pw, ph, xlim, ylim, color, title, xlab, ylab):
    def px(v):
        return ox + (v - xlim[0]) / (xlim[1] - xlim[0]) * pw

    def py(v):
        return oy + ph - (v - ylim[0]) / (ylim[1] - ylim[0]) * ph

    out = [f'<rect x="{ox}" y="{oy}" width="{pw}" height="{ph}" fill="#ffffff" stroke="{INK}"/>']
    for tk in nice_ticks(*xlim):
        out.append(f'<line x1="{px(tk):.1f}" y1="{oy + ph}" x2="{px(tk):.1f}" y2="{oy + ph - 4}" stroke="{INK}"/>')
        out.append(f'<text x="{px(tk):.1f}" y="{oy + ph + 15}" text-anchor="middle">{fmt(tk)}</text>')
    for tk in nice_ticks(*ylim):
        out.append(f'<line x1="{ox}" y1="{py(tk):.1f}" x2="{ox + 4}" y2="{py(tk):.1f}" stroke="{INK}"/>')
        out.append(f'<text x="{ox - 6}" y="{py(tk) + 4:.1f}" text-anchor="end">{fmt(tk)}</text>')
    pts = ' '.join(f'{px(a):.1f},{py(b):.1f}' for a, b in zip(xs, ys))
    out.append(f'<polyline fill="none" stroke="{color}" stroke-width="1.5" points="{pts}"/>')
    out.append(f'<text x="{ox + pw / 2}" y="{oy - 8}" text-anchor="middle" font-weight="bold">{title}</text>')
    out.append(f'<text x="{ox + pw / 2}" y="{oy + ph + 32}" text-anchor="middle">{xlab}</text>')
    out.append(f'<text transform="translate({ox - 36},{oy + ph / 2}) rotate(-90)" '
               f'text-anchor="middle">{ylab}</text>')
    return '\n'.join(out)


def main(svg_path, amp_x=5.0, amp_y=5.0, freq_x=1.0, freq_y=2.0):
    W, H = 960, 600
    svg = [f'<svg xmlns="http://www.w3.org/2000/svg" width="{W}" height="{H}" viewBox="0 0 {W} {H}" '
           f'font-family="Helvetica, Arial, sans-serif" font-size="12" fill="{INK}">',
           f'<rect width="{W}" height="{H}" fill="#ffffff"/>',
           f'<text x="{W / 2}" y="22" text-anchor="middle" font-size="14">'
           f'Re-plot of updatePlots() in Waveform_NOW2: Ax = {fmt(amp_x)}, Ay = {fmt(amp_y)}, '
           f'fx = {fmt(freq_x)}, fy = {fmt(freq_y)}</text>']

    # top row: x(t) and y(t) at theta = 45 deg
    t, x, y, xl, yl = update_plots(amp_x, amp_y, freq_x, freq_y, 45)
    svg.append(panel(t, x, 70, 64, 380, 140, (0, 2 * math.pi), (-xl, xl), BLUE,
                     'x(t), θ = 45°', 'Samples', 'Amplitude'))
    svg.append(panel(t, y, 550, 64, 380, 140, (0, 2 * math.pi), (-yl, yl), RED,
                     'y(t), θ = 45°', 'Samples', 'Amplitude'))

    # bottom row: XY plot for theta = 0, 45, 90 deg (equal aspect, square panels)
    for i, th in enumerate((0, 45, 90)):
        t, x, y, xl, yl = update_plots(amp_x, amp_y, freq_x, freq_y, th)
        svg.append(panel(x, y, 70 + i * 315, 290, 260, 260, (-xl, xl), (-yl, yl), GREEN,
                         f'XY Plot: y(t) vs. x(t), θ = {th}°', 'x(t)', 'y(t)'))
    svg.append('</svg>')
    with open(svg_path, 'w', encoding='utf-8', newline='\n') as fh:
        fh.write('\n'.join(svg) + '\n')


if __name__ == '__main__':
    if len(sys.argv) not in (2, 6):
        sys.exit(__doc__)
    main(sys.argv[1], *[float(a) for a in sys.argv[2:]])
