# HW1-유한 전위 우물 문제

## I. 문제 조건
- $Al_{0.3}Ga_{0.7}As$ 사이에 $GaAs$가 있는 구조이다.
- $Al_{0.3}Ga_{0.7}As$의 $E_c, E_v$의 차이는 1.85 eV이다.
- $GaAs$의 $E_v$가 $Al_{0.3}Ga_{0.7}As$의 $E_v$보다 0.14 eV 더 크고, $GaAs$의 $E_c$가 $Al_{0.3}Ga_{0.7}As$의 $E_c$보다 0.28 eV 더 작다.
- $GaAs$의 폭은 $50\r{A}$이다.
- $m_n = m_n^{*}\cdot m_o = 0.067m_o$
- $m_h = m_h^{*}\cdot m_o = 0.45m_o$
- $m_o = 9.11 \cdot 10^{-31} kg$

## II. 유의사항
- MATLAB 이용한 $E_{nn}, E_{hn}$ 과 $\psi_n, \psi_h$ 시뮬레이션 및 그래프 plot
- MATLAB 코드와 시뮬레이션 결과를 첨부하고, 결과에 대한 해석을 작성하라.

## III. 유한 전위 우물 문제의 식을 유도하자
### 1) 주어진 전위의 조건

$$
V(x)=\begin{cases}
V_0&(x<-a)\\
0&(-a<x<a)\\
V_0&(x>a)
\end{cases}
$$

### 2) 주어진 조건에 따라 미분방정식을 해결한다

$$
\begin{aligned}
\left[\frac{-\hbar^2}{2m}\frac{d^2}{dx^2}+V(x)\right]\psi(x)&=E\psi(x)\\[6pt]
&\Rightarrow
\begin{cases}
\frac{d^2}{dx^2}\psi(x)+\frac{2m}{\hbar^2}[E+V_0]\psi(x)=0&(-a<x<a)\\[6pt]
\frac{d^2}{dx^2}\psi(x)-\frac{2m}{\hbar^2}[-E]\psi(x)=0&(x<-a,\; x>a)
\end{cases}
\end{aligned}
$$

$$
\begin{aligned}
\frac{d^2}{dx^2}\psi(x)+\frac{2m}{\hbar^2}[E+V_0]\psi(x)&=0\\[6pt]
K_0^2&=\frac{2m}{\hbar^2}[E+V_0]\\[6pt]
\psi_0(x)&=A_0\sin(K_0x)+B_0\cos(K_0x)
\end{aligned}
$$

$$
\begin{aligned}
\frac{d^2}{dx^2}\psi(x)-\frac{2m}{\hbar^2}[-E]\psi(x)&=0\\[6pt]
K^2&=\frac{-2mE}{\hbar^2}\\[6pt]
\psi(x)&=Ae^{Kx}+Be^{-Kx}
\end{aligned}
$$

따라서

$$
\psi(x)=\begin{cases}
A_-e^{Kx}+B_-e^{-Kx}&(x<-a)\\[6pt]
A_0\sin(K_0x)+B_0\cos(K_0x)&(-a<x<a)\\[6pt]
A_+e^{Kx}+B_+e^{-Kx}&(x>a)
\end{cases}
$$

### 3) 경계조건을 이용하여 상수를 결정한다

경계조건:
$$
\psi(\pm\infty)=0,\quad \psi,\frac{d\psi}{dx}\text{는 연속이다.}
$$

따라서
$$
B_-=0,\quad A_+=0
$$

최종적으로

$$
\psi(x)=\begin{cases}
A_-e^{Kx}&(x<-a)\\[6pt]
A_0\sin(K_0x)+B_0\cos(K_0x)&(-a<x<a)\\[6pt]
B_+e^{-Kx}&(x>a)
\end{cases}
$$

경계에서 연속조건을 이용하여 관계식을 얻고, 최종 방정식은 다음과 같다.

### 4) 결론

특성방정식은 다음과 같다.

$$
K=\begin{cases}
-K_0\cot(K_0a)\\[6pt]
K_0\tan(K_0a)
\end{cases}
$$

$$
K_0^2+K^2=\frac{2mV_0}{\hbar^2}=K_C^2
$$

이 두 방정식에서 $K_0$와 $K$를 결정하여 에너지 준위 $E_{hn}, E_{nn}$ 및 파동함수 $\psi(x)$를 구하면 된다.
