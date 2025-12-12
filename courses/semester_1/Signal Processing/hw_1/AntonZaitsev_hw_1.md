---
title: Signal Processing | Homework 1
author: Anton Zaitsev | 0230981826
date: \today{}
usepackage:
    - amsmath
    - geometry
    - float
header-includes: |
    \usepackage{caption}
    \usepackage{float}
    \usepackage{graphicx}
output: pdf_document
geometry: "left=25mm, right=25mm, top=10mm, bottom=25mm"
---

\pagebreak

# Exercise 1

Show properties of Fourier Transform 1 and 3.

## Property 1

Fourier Transform of a translated signal is Fourier Transform of original signal multiplied by $e^{-ivh}$:

$$F(\tau_hf)(v) = F(f)(v)e^{-ivh}, \tau_h(f)=f(t-h)$$
Fourier Transform of a signal $f(t)$ is: 
$$F(f)(v) = \int_\mathbb{R}f(t)e^{-ivt}dt$$
Fourier Transform of translated signal $f(t-h)$ is:
$$F(f(t-h))(v) = F(\tau_hf)(v) = \int_\mathbb{R}f(t-h)e^{-ivt}dt$$
Let $a=t-h$. Then Fourier Transform for a translated signal $f(t-h) = f(a)$ is:
$$F(\tau_hf)(v) = \int_\mathbb{R}f(a)e^{-iv(a+h)}da$$
Since $e^{-ivh}$ is a constant, we can take it out of the integral with respect to $a$:
$$F(\tau_hf)(v) = e^{-ivh}\int_\mathbb{R}f(a)e^{-iva}da$$
Since $\int_\mathbb{R}f(a)e^{-iva}da = \int_\mathbb{R}f(t)e^{-ivt}dt$ we have:
$$F(\tau_hf)(v) = e^{-ivh}\int_\mathbb{R}f(t)e^{-ivt}dt = F(f)(v)e^{-ivh}$$
$\square$

## Property 3

Fourier Transform of derivative of a signal is derivative of Fourier Transform of original signal, or Fourier Transform of original signal multiplied by $iv$:

$$F(f')(v) = (F(f))'(v) = ivF(f)(v)$$
$$\tag{1.1}f(t) = \frac{1}{2\pi}\int_\mathbb{R}F(f)e^{ivt}dv$$
$$\frac{d}{dt}f(t) = \frac{d}{dt}\frac{1}{2\pi}\int_\mathbb{R}F(f)e^{ivt}dv$$
By using the Leibniz Integral Rule, we can move the derivative inside the integral, since the derivative is over $t$ and we are integrating over $v$:
$$\frac{d}{dt}f(t) = \frac{1}{2\pi}\int_\mathbb{R}F(f)\frac{d}{dt}e^{ivt}dv = \frac{1}{2\pi}\int_\mathbb{R}ivF(f)e^{ivt}dv$$
Let $G(f) = ivF(f)$. Then:
$$\tag{1.2}\frac{d}{dt}f(t) = \frac{1}{2\pi}\int_\mathbb{R}G(f)e^{ivt}dv$$
From equation $1.1$ we can notice that the Fourier Transform of a signal $f(t)$ is $F(f)$ and from the equation $1.2$ the Fourier Transform of a derivative of a signal $f'(t)$ is $G(f) = ivF(f)$. Thus, Fourier Transform of a derivative of a signal is Fourier Transform of original signal multiplied by $iv$.

$\square$

\pagebreak

# Exercise 2

Compute the support, verify if the signal is stable, of finite energy and compute the Fourier Transform, if defined.

$$f_2(t) = \begin{cases}-1& -a \le t < 0 \\ 1& 0 \le t < a \\ 0 & otherwise \end{cases}, \space\space\space\space a > 0$$

```{=latex}
\begin{figure}[H]
\begin{center}
\caption{\label{figure-8}Graph of $f_2(t)$}
\includegraphics[width=4in]{./image-1.png}
\hfill
\caption*{\textit{Note: }Solid blue line represents the graph of the function $f_2(t)$.}
\end{center}
\end{figure}
```

## Support

The support of the signal $supp(f_2)$ is the closure of $f_2(t)$ where $f_2(t) \ne 0$. Since $f_2(t) \ne 0$ for $t \in [-a, a)$, the support is equal to:
$$supp(f_2) = \overline{[-a, a)} = [-a, a]$$

## Stable

To check whether the signal is stable we have to compute $L^1(f(t))$ and make sure it does not diverge.
$$L^1(f_2(t)) = \int_{\mathbb{R}}|f_2(t)|dt = \int_{-a}^0|-1|dt + \int_{0}^a|1|dt = \int_{-a}^a1dt=$$
$$\lim_{t\to a}t|^{t=a}_{t=-a} = a - (-a) = 2a$$
Since $L^1(f_2(t)) < \infty$, we proved that it is stable.

## Finite Energy

To check whether the signal of finite energy, we have to compute $L^2$ of the signal.
$$L^2(f_2) = \int_{-a}^0|(-1)^2|dt + \int^a_0|(1)^2|dt = \int^a_{-a}dt = \lim_{t\to a}[t]|^{t=a}_{t=-a} = a - (-a) = 2a$$

Since $L^2(f_2(t)) < \infty$, we proved that it is of finite energy.

## Fourier Transform

We can evaluate Fourier Transform of a signal $f_2(t)$ as follows:
$$F(f_2)(v) = \int_{-a}^af_2(t)e^{-ivt}dt=$$
$$=\int_{-a}^0-e^{-ivt}dt + \int^a_0e^{-ivt}dt = \frac{1}{iv}e^{-ivt}|^{t=0}_{t=-a} - \frac{1}{iv}e^{-ivt}|^{t=a}_{t=0}$$
$$=\frac{1}{iv}(e^{-ivt}|^{t=0}_{t=-a} - e^{-ivt}|^{t=a}_{t=0})=\frac{1}{iv}(1 -e^{iva} - e^{-iva} + 1)=\frac{2 - e^{iva} -
 e^{-iva}}{iv}$$

\pagebreak

# Exercise 3

Compute the support, verify if the signal is stable, of finite energy and compute the Fourier Transform, if defined.

## Signal $f_4(t)$

$$f_4(t) = \cos(at)e^{-|t|}$$

To draw a sketch of the signal, we would need to draw in three dimensions. To make this a little easier for us, we can fix variable $a$ and see how functions behaves for various values of $a$. Let us fix $a_1 = 0, a_2 = 2, a_3 = 4$ and draw functions for these values of $a$.

```{=latex}
\begin{figure}[H]
\begin{center}
\caption{\label{figure-8}Sketch of $f_4(t), a=0$}
\includegraphics[width=4in]{./41.jpg}
\hfill
\end{center}
\end{figure}
```
```{=latex}
\begin{figure}[H]
\begin{center}
\caption{\label{figure-8}Sketch of $f_4(t), a=0$}
\includegraphics[width=4in]{./42.jpg}
\hfill
\end{center}
\end{figure}
```
```{=latex}
\begin{figure}[H]
\begin{center}
\caption{\label{figure-8}Sketch of $f_4(t), a=0$}
\includegraphics[width=4in]{./43.jpg}
\hfill
\end{center}
\end{figure}
```

### Support

The function $\cos(at)e^{-|t|}=0 \iff cos(ax) = 0$. The function $cos(ax) = 0$ when $ax = \frac{\pi}{2} + \pi n, n \in \mathbb{N}$. Even though the function equals to 0 at these points, support includes all the points where the function is non-zero and their limit points, even if the function is zero at those points. Thus, the support of $f_4(t)$ is the set of all real numbers:
$$supp(f_4(t)) = \mathbb{R}$$

### Stable

Check $L^1(f_4(t))$:
$$L^1(f_4(t)) = \int_{\mathbb{R}}|f_4(t)|dt = \int_{\mathbb{R}}|\cos(at)e^{-|t|}|dt$$
Since the function $f_4(t)$ is even, we have:
$$\int_{\mathbb{R}}|f_4(t)|dt = 2 \int_0^{+\infty}f_4(t)dt = 2 \int_0^{+\infty}\cos(at)e^{-|t|}dt$$
Note that we integrate over positive values, $t > 0$. Thus, we can expand modulus:
$$\tag{2.1}\int_{\mathbb{R}}f_4(t)dt = 2 \int_0^{+\infty}\cos(at)e^{-t}dt$$
Let us solve $\int_0^{+\infty}\cos(at)e^{-t}dt$. We can solve this integral by integrating by parts twice. Let $f = e^{-t}, f'=-e^{-t}, g=\frac{1}{a}\sin(at), g'=\cos(at)$. We have:
$$\int_0^{+\infty}\cos(at)e^{-t}dt = e^{-t}\frac{\sin(at)}{a} - \int_0^{+\infty}(-e^{-t})(\frac{1}{a}\sin(at))dt$$
Now integrate $\int_0^{+\infty}(-e^{-t})(\frac{1}{a}\sin(at))dt$ by parts again: $f = -e^{-t}, f' = e^{-t}, g=-\frac{1}{a^2}\cos(at), g'=\frac{1}{a}\sin(at)$. We get:
$$\int_0^{+\infty}(-e^{-t})(\frac{1}{a}\sin(at))dt = -e^{-t}(-\frac{1}{a^2}\cos(at)) - \int_0^{+\infty}e^{-t}(-\frac{1}{a^2}\cos(at))dt=$$
$$=\frac{1}{a^2}e^{-t}\cos(at) + \frac{1}{a^2}\int_0^{+\infty}e^{-t}\cos(at)dt$$
Now going back to the integral $\int_0^{+\infty}\cos(at)e^{-t}$, combining everything together we have:
$$\int_0^{+\infty}\cos(at)e^{-t}dt = e^{-t}\frac{\sin(at)}{a} - \frac{1}{a^2}e^{-t}\cos(at) - \frac{1}{a^2}\int_0^{+\infty}e^{-t}\cos(at)dt=$$
$$=(\frac{a^2+1}{a^2})\int_0^{+\infty}e^{-t}\cos(at)dt = \frac{ae^{-t}\sin(at) - e^{-t}\cos(at)}{a^2}$$
$$(\frac{a^2+1}{a^2})\int_0^{+\infty}e^{-t}\cos(at)dt = \frac{e^{-t}(a\sin(at) - \cos(at))}{a^2}$$
$$\int_0^{+\infty}e^{-t}\cos(at)dt = \frac{a\sin(at) - \cos(at)}{e^{t}(a^2+1)}$$
Now, substitute this fraction to the equation $2.1$ and evaluate it:
$$\tag{2.2}L^1(f_4(t)) = 2 \int_0^{+\infty}\cos(at)e^{-t}dt = \lim_{l \to +\infty}\frac{2(a\sin(at) - \cos(at))}{e^{t}(a^2+1)}|^{t=l}_{t=0} = \frac{1}{a^2+1}$$
Thus, we proved that the function $f_4(t)$ is stable.

### Finite Energy

Function $f^2_4(t)$ is also even, so we can also evaluate the integral $\forall t > 0$ from $0$ to $+\infty$ and multiply it by $2$:

$$L^2(f_4(t)) = \int_{\mathbb{R}}|f^2_4(t)|dt=2\int^{+\infty}_0(|e^{-t}\cos(at)|)^2dt = 2\int^{+\infty}_0e^{-2t}\cos^2(at)dt$$
We can use trigonometric identity $cos^2(at) =\frac{cos(2at)+1}{2}$:
$$\int_{\mathbb{R}}f^2_4(t)dt = 2\int^{+\infty}_0e^{-2t}\frac{1}{2}(\cos(2at) + 1)dt = \int^{+\infty}_0e^{-2t}\cos(2at)dt + \int^{+\infty}_0e^{-2t}dt$$
We can notice that the integral $\int^{+\infty}_0e^{-2t}\cos(2at)dt$ is almost the same as in the equation $2.1$. The main difference here is multiplier $2$ inside $\cos(2at)$. After integrating this integral twice, we would get the same answer $\frac{1}{a^2+1}$ but the denominator would be multiplied by $2$:
$$\tag{2.3}\int^{+\infty}_0e^{-2t}\cos(2at)dt=\frac{1}{2a^2+2}$$

Now let us solve $\int^{+\infty}_0e^{-2t}dt$. This integral can be solved using basic integral rules.
$$\int^{+\infty}_0e^{-2t}dt = -\frac{1}{2}\lim_{l \to +\infty}e^{-2t}|^{t=l}_{t=0} = \frac{1}{2}$$
Thus, the function $f_4(t)$ is of finite energy:
$$L^2(f_4(t)) = \frac{1}{2a^2+2} + \frac{1}{2} = \frac{a^2 + 2}{2a^2 + 2}$$

### Fourier Transform

Since the function $f_4(t)$ is even, the Fourier Transform of $f_4(t)$ is real. Thus:

$$F(f_4) = \int_{\mathbb{R}}f_4(t)\cos(vt)dt = \int_{\mathbb{R}}e^{-|t|}\cos(at)\cos(vt)dt$$
We can use trigonometric identity: $\cos(at)\cos(vt)=\frac{1}{2}[cos(at + vt) + cos(at - vt)]$. Thus, we get:
$$F(f_4) = \frac{1}{2}\int_{\mathbb{R}}e^{-|t|}[cos(t(a+v)) + cos(t(a-v))]dt$$
Function $e^{-|t|}[cos(t(a+v)) + cos(t(a-v))]$ is even, symmetric with respect to the ordinate, thus:
$$F(f_4) = \int^{+\infty}_0e^{-t}[cos(t(a+v)) + cos(t(a-v))]dt=$$
$$=\int^{+\infty}_0e^{-t}cos(t(a+v))dt + \int^{+\infty}_0e^{-t}cos(t(a-v))dt$$
Next, we need to evaluate each integral. Again, the main difference between these two integrals and the ones in $2.2$ and $2.3$ is what inside the cosine function. We can simply skip the computation part and move to the summation of evaluated integrals:
$$\int^{+\infty}_0e^{-t}cos(t(a+v))dt = \frac{1}{(a+v)^2+1}$$
$$\int^{+\infty}_0e^{-t}cos(t(a-v))dt = \frac{1}{(a-v)^2+1}$$
$$F(f_4) = \frac{1}{(a+v)^2+1} + \frac{1}{(a-v)^2+1} = \frac{2(a^2 + v^2 + 1)}{((a+v)^2+1)((a-v)^2+1)}$$

\pagebreak

## Signal $f_5(t)$

$$f_5(t) = e^{-\pi t^2}$$

```{=latex}
\begin{figure}[H]
\begin{center}
\caption{\label{figure-8}Sketch of $f_5(t)$}
\includegraphics[width=4in]{./5.jpg}
\hfill
\end{center}
\end{figure}
```

### Support

The function $f_5(t) \ne 0 \space \forall t \in \mathbb{R}$, thus:
$$supp(f_5(t)) = \mathbb{R}$$

### Stable

To verify $f_5(t)$ is stable, compute $L^1(f_5(t))$:
$$\tag{3.1}L^1(f_5(t)) = \int_{\mathbb{R}}|e^{-\pi t^2}|dt$$
Since the exponent function is always positive, we have:
$$L^1(f_5(t)) = \int_{\mathbb{R}}|e^{-\pi t^2}|dt = \int_{\mathbb{R}}e^{-\pi t^2}dt$$
To find the value of this integral, we can switch to polar coordinates. First, let us define integral $I$:
$$I = \int_{\mathbb{R}}e^{-\pi t^2}dt = \int_{\mathbb{R}}e^{-\pi x^2}dx = \int_{\mathbb{R}}e^{-\pi y^2}dy$$
$$I^2 = \int_{\mathbb{R}}e^{-\pi x^2}dx \cdot \int_{\mathbb{R}}e^{-\pi y^2}dy = \int_{\mathbb{R}}\int_{\mathbb{R}}e^{-\pi(x^2+y^2)}dxdy$$
Switch to polar coordinates:
$$\int_0^{2\pi}\int^{\mathbb{R}}_0e^{-\pi r^2}rdrd\theta$$
Let us compute $\int^{\mathbb{R}}_0e^{-\pi r^2}rdr$. We can compute it using $u$-substitution: $u=r^2, \frac{du}{dt}=2r, dr = \frac{du}{2r}$. Thus, we have:
$$\int^{\mathbb{R}}_0e^{-\pi r^2}rdr = \int^{\mathbb{R}}_0e^{-\pi u}r\frac{du}{2r} = \frac{1}{2}\int^{\mathbb{R}}_0e^{-\pi u}du=$$
$$=-\frac{1}{2\pi}\lim_{l \to +\infty}e^{-\pi u}|^{u=l}_{u=0} = \frac{1}{2\pi}$$
Next, find $\int_0^{2\pi}d\theta$:
$$\int_0^{2\pi}d\theta = \theta|^{\theta=2\pi}_{\theta=0} = 2\pi$$
Thus, we have:
$$I^2 = \frac{1}{2\pi} \cdot 2\pi = 1$$
$$I = \pm 1$$
Since $\int_{\mathbb{R}}e^{-\pi t^2}dt > 0$:
$$L^1(f_5(t)) = 1$$

Thus, $f_5(t)$ is stable.

### Finite Energy

To see if $f_5(t)$ is of finite energy, evaluate $L^2(f_5(t))$:
$$L^2(f_5(t)) = \int_{\mathbb{R}}|e^{-\pi t^2}|^2dt = \int_{\mathbb{R}}e^{-2\pi t^2}dt$$
We can solve it the same way we solved $3.1$. Since this integral is similar to $L^1(f_5(t))$, we can notice that when we switch to polar coordinates, $2$ from the power of the exponent will go to the denominator, thus: 
$$\int^{\mathbb{R}}_0e^{-2\pi r^2}rdr = \frac{1}{4\pi}$$
Then, we can finish the integral evaluation:
$$I^2 = \frac{1}{4\pi}\int_0^{2\pi}d\theta = \frac{1}{4\pi}\theta|^{\theta=2\pi}_{\theta=0} = \frac{1}{2}$$
$$I = \sqrt{\frac{1}{2}} = \frac{\sqrt{2}}{2}$$
Hence the signal $f_5(t)$ is of finite energy:
$$L^2(f_5(t)) = \frac{\sqrt{2}}{2}$$

### Fourier Transform

$$F(f_5) = \int_{\mathbb{R}}e^{-\pi t^2}e^{-ivt}dt = \int_{\mathbb{R}}e^{-(\pi t^2+ivt)}dt$$
We can notice that $e^{-(\pi t^2+ivt)}$ is almost in the form that can be converted to polar coordinates. We need to convert $(\pi t^2+ivt)$ to the form $(at + y)^2$, so that we can move $e^y$ from the integral (as a constant) and switch $e^{(at)^2}$ to the polar coordinates (here $a$ and $y$ are just some constants). In fact, we have:
$$(\sqrt{\pi}t+\frac{iv}{2\sqrt{\pi}})^2 = \pi t^2 + ivt - \frac{v^2}{4\pi}$$
$$(\sqrt{\pi}t+\frac{iv}{2\sqrt{\pi}})^2 + \frac{v^2}{4\pi} = \pi t^2 + ivt$$
Thus:
$$F(f_5)=\int_{\mathbb{R}}e^{-(\pi t^2+ivt)}dt = \int_{\mathbb{R}}e^{-((\sqrt{\pi}t+\frac{iv}{2\sqrt{\pi}})^2 + \frac{v^2}{4\pi})}dt = \int_{\mathbb{R}}e^{-(\sqrt{\pi}t+\frac{iv}{2\sqrt{\pi}})^2 - \frac{v^2}{4\pi}}dt=$$
$$=e^{- \frac{v^2}{4\pi}}\int_{\mathbb{R}}e^{-(\sqrt{\pi}t+\frac{iv}{2\sqrt{\pi}})^2}dt$$
Now we can compute $\int_{\mathbb{R}}e^{-(\sqrt{\pi}t+\frac{iv}{2\sqrt{\pi}})^2}dt$ using $u$-substitution. Let $u = \sqrt{\pi}t+\frac{iv}{2\sqrt{\pi}}, \frac{du}{dt} = \sqrt{\pi}, dt=\frac{du}{\sqrt{\pi}}$. Thus:
$$\int_{\mathbb{R}}e^{-(\sqrt{\pi}t+\frac{iv}{2\sqrt{\pi}})^2}dt = \frac{1}{\sqrt{\pi}}\int_{\mathbb{R}}e^{-u^2}du$$
By switching to polar coordinates, we will get that $\int_{\mathbb{R}}e^{-u^2}du = \sqrt{\pi}$ (Check: $\int^{\mathbb{R}}_0e^{-\pi r^2}rdr = \frac{1}{2}, \int_0^{2\pi}d\theta = 2\pi, I^2 = \pi, I = \sqrt{\pi}$). Hence, the Fourier Transform of $f_5(t)$ is:
$$F(f_5) = e^{- \frac{v^2}{4\pi}} \cdot \frac{1}{\sqrt{\pi}} \cdot \sqrt{\pi} = e^{- \frac{v^2}{4\pi}}$$
