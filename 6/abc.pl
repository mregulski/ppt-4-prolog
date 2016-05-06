abc(0) --> [].
abc(N) --> a(N), b(N), c(N).

a(0) --> [].
a(N) --> [a], a(M), {N is M + 1}.

b(0) --> [].
b(N) --> [b], b(M), {N is M + 1}.

c(0) --> [].
c(N) --> [c], c(M), {N is M + 1}.
