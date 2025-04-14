# HW1-유한 전위 우물 문제
## I. 문제 조건
- $Al_{0.3}Ga_{0.7}As$사이에 $GaAs$가 있는 구조이다.
- $Al_{0.3}Ga_{0.7}As$의 $E_c, E_v$의 차이는 1.85ev이다.
- $GaAs$의 $E_v$가 $Al_{0.3}Ga_{0.7}As$의 $E_v$보다 0.14eV 더 크고, $GaAs$의 $E_c$가 $Al_{0.3}Ga_{0.7}As$의 $E_c$보다 0.28eV 더 작다.
- $GaAs$의 폭은 $50 Å$이다.
- $m_n = m_n^{*}\cdot m_o = 0.067m_o$
- $m_h = m_h^{*}\cdot m_o = 0.45m_o$
- $m_o = 9.11 \cdot 10^{-31} kg$

## II. 유의사항
- MATLAB 이용한 $E_{nn}, E_{hn}$ 과 $\psi_n, \psi_h$ 시뮬레이션 및 그래프 plot
- MATLAB 코드와 시뮬레이션 결과를 첨부하고, 결과에 대한 해석을 작성하라.

## III. 유한 전위 우물 문제의 식을 유도하자
### 1) 주어진 전위의 조건

$$
V(x)=
\begin{cases}
V_0 & \text{for } x < -a \\
0 & \text{for } -a < x < a \\
V_0 & \text{for } x > a
\end{cases}
$$

### 2) 주어진 조건에 따라 미분방정식을 해결한다

$$
[\frac{-ℏ^2}{2m}\frac{d^2}{dx^2} +V(x)]\psi(x)=E\psi(x)
$$

$$
\begin{cases}
\dfrac{d^2}{dx^2}\psi(x)-\dfrac{2m}{\hbar^2}[-E]\psi(x)=0 & \text{for } x < -a \\
\dfrac{d^2}{dx^2}\psi(x)+\dfrac{2m}{\hbar^2}[E+V_0]\psi(x)=0 & \text{for } -a < x < a \\
\dfrac{d^2}{dx^2}\psi(x)-\dfrac{2m}{\hbar^2}[-E]\psi(x)=0 & \text{for } x > a
\end{cases}
$$

$$
\begin{aligned}
\frac{d^2}{dx^2}\psi(x)+\frac{2m}{ℏ^2}[E+V_0]\psi(x)&=0\\
K_0^2=\frac{2m}{ℏ^2}[E+V_0]\\
\frac{d^2}{dx^2}\psi(x)+K_0^2\psi(x)&=0\\
\therefore \psi_0(x)=A_0\sin(K_0x)+B_0\cos(K_0x)
\end{aligned}
$$

$$
\begin{aligned}
\frac{d^2}{dx^2}\psi(x)-\frac{2m}{ℏ^2}[-E]\psi(x)&=0\\
K^2=\frac{-2mE}{ℏ^2}\\
\frac{d^2}{dx^2}\psi(x)-K^2\psi(x)&=0\\\\
\psi(x)=Ae^{Kx}+Be^{-Kx}\\
\therefore \begin{cases}
\psi_-(x)=A_-e^{Kx}+B_-e^{-Kx}&(x<-a)\\
\psi_+(x)=A_+e^{Kx}+B_+e^{-Kx}&(x>a)\\
\end{cases}
\end{aligned}
$$

$$
\psi(x)=\begin{cases}
\psi_-(x)=A_-e^{Kx}+B_-e^{-Kx}&(x<-a)\\
\psi_0(x)=A_0\sin(K_0x)+B_0\cos(K_0x)&(-a<x<a)\\
\psi_+(x)=A_+e^{Kx}+B_+e^{-Kx}&(x>a)\\
\end{cases}
$$

### 3) 경계조건을 이용하여 상수를 결정한다

$$
\psi(x)=\begin{cases}
\psi_-(-\infty)=0&(1)\\
\psi_+(\infty)=0&(2)\\
\psi_0(-a)=\psi_-(-a)&(3)\\
\psi_0(a)=\psi_+(a)&(4)\\
\frac{d}{dx}\psi_0(-a)=\frac{d}{dx}\psi_-(-a)&(5)\\
\frac{d}{dx}\psi_0(a)=\frac{d}{dx}\psi_+(a)&(6)\\
\end{cases}
$$

- $(1)$, $(2)$ 에서 $B_{-}=0$, $A_+=0$
    
$$
\psi(x)=\begin{cases}
\psi_-(x)=A_-e^{Kx}&(x<-a)\\
\psi_0(x)=A_0\sin(K_0x)+B_0\cos(K_0x)&(-a<x<a)\\
\psi_+(x)=B_+e^{-Kx}&(x>a)\\
\end{cases}
$$

$$
\frac{d}{dx}\psi(x)=\begin{cases}
\frac{d}{dx}\psi_-(x)=A_-Ke^{Kx}&(x<-a)\\
\frac{d}{dx}\psi_0(x)=A_0K_0\cos(K_0x)-B_0K_0\sin(K_0x)&(-a<x<a)\\
\frac{d}{dx}\psi_+(x)=-B_+Ke^{-Kx}&(x>a)\\
\end{cases}
$$

$$
\psi(x)=\begin{cases}
A_-e^{-Ka}=A_0\sin(-K_0a)+B_0\cos(-K_0a)&(3)\\
B_+e^{-Ka}=A_0\sin(K_0a)+B_0\cos(K_0a)&(4)\\
A_-Ke^{-Ka}=A_0K_0\cos(-K_0a)-B_0K_0\sin(-K_0a)&(5)\\
-B_+Ke^{-Ka}=A_0K_0\cos(K_0a)-B_0K_0\sin(K_0a)&(6)\\
\end{cases}
$$
    
- $(3)\cdot K$, $(5)\cdot -1$ 에서
    
$$
\begin{aligned}
\psi(x)&=\begin{cases}
A_-Ke^{-Ka}=A_0K\sin(-K_0a)+B_0K\cos(-K_0a)&(3)\\
-A_-Ke^{-Ka}=-A_0K_0\cos(-K_0a)+B_0K_0\sin(-K_0a)&(5)
\end{cases}\\
0&=A_0(K\sin(-K_0a)-K_0\cos(-K_0a))+B_0(K\cos(-K_0a)-K_0\sin(-K_0a))\\
&\begin{cases}
K\sin(-K_0a)-K_0\cos(-K_0a)=0\\
K\cos(-K_0a)+K_0\sin(-K_0a)=0
\end{cases}
\end{aligned}
$$
    
- $(4)\cdot K$, $(6)$ 에서
    
$$
\begin{aligned}
\psi(x)&=\begin{cases}
B_+Ke^{-Ka}=A_0K\sin(K_0a)+B_0K\cos(K_0a)&(4)\\
-B_+Ke^{-Ka}=A_0K_0\cos(K_0a)-B_0K_0\sin(K_0a)&(6)\\
\end{cases}\\
0&=A_0(K\sin(K_0a)+K_0\cos(K_0a))+B_0(K\cos(K_0a)-K_0\sin(K_0a))\\
&\begin{cases}
K\sin(K_0a)+K_0\cos(K_0a)=0\\
K\cos(K_0a)-K_0\sin(K_0a)=0
\end{cases}
\end{aligned}
$$


### 4) 결론

$$
\begin{aligned}
\therefore K&=
\begin{cases}
-K_0\cot(K_0a)\\
K_0\tan(K_0a)
\end{cases}&(1)
\end{aligned}
$$

$$
\begin{aligned}
K_0^2&=\frac{2m}{ℏ^2}[E+V_0]\\
K^2&=\frac{-2mE}{ℏ^2}\\
\therefore &K_0^2+K^2=\frac{2mV_0}{ℏ^2}=K_C^2&(2)
\end{aligned}
$$

- $(1), (2)$를 이용하여 모든  $K_0$값을 구하고 이를 바탕으로 $\psi(x)$와 $E_{hn}, E_{nn}$을 구하면 된다