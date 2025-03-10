Module:     v3d
Synopsis:   Three dimension vector
Author:     Fernando Raya
Copyright:  (c) 2020
License:    See LICENSE file

define method similar
    (x :: <float>, y :: <float>, #key epsilon = 0.00001 )
 => (equal? :: <boolean>)
  abs(x - y) < epsilon
end;

define sealed class <v3> (<object>)
  slot v-x :: <float> = 0.0, init-keyword: x:, setter: #f;
  slot v-y :: <float> = 0.0, init-keyword: y:, setter: #f;
  slot v-z :: <float> = 0.0, init-keyword: z:, setter: #f;
end class <v3>;

define function v3d
    (x :: <float>, y :: <float>, z :: <float>)
 => (v :: <v3>)
  make(<v3>, x: x, y: y, z: z)
end;

define method print-object
    (v :: <v3>, s :: <stream>) => ()
  format(s, "v3(%=, %=, %=)", v.v-x, v.v-y, v.v-z)
end;

define constant $v3-zero 
  = make(<v3>);

define method \=
    (a :: <v3>, b :: <v3>) => (equal? :: <boolean>)
  similar(a.v-x, b.v-x) & similar(a.v-y, b.v-y) & similar(a.v-z, b.v-z)
end;

define method \+
    (a :: <v3>, b :: <v3>) => (sum :: <v3>)
  make(<v3>, x: a.v-x + b.v-x, y: a.v-y + b.v-y, z: a.v-z + b.v-z)  
end;

define method \-
    (a :: <v3>, b :: <v3>) => (difference :: <v3>)
  make(<v3>, x: a.v-x - b.v-x, y: a.v-y - b.v-y, z: a.v-z - b.v-z)
end;

define method negative
    (p :: <v3>) => (negated :: <v3>)
  make(<v3>, x: -p.v-x, y: -p.v-y, z: -p.v-z)
end;

define method \*
    (p :: <v3>, n :: <number>) => (product :: <v3>)
  make(<v3>, x: p.v-x * n, y: p.v-y * n, z: p.v-z * n)
end;

define method \/
    (p :: <v3>, n :: <number>) => (division :: <v3>)
  make(<v3>, x: p.v-x / n, y: p.v-y / n, z: p.v-z / n)
end;

define method \*
    (a :: <v3>, b :: <v3>) => (n :: <float>)
  (a.v-x * b.v-x) + (a.v-y * b.v-y) + (a.v-z * b.v-z)
end;

define method squared
    (v :: <v3>) => (n :: <float>)
  v * v
end;

define method magnitude
    (v :: <v3>) => (n :: <float>)
  sqrt(squared(v))
end;

define method cross-product
    (a :: <v3>, b :: <v3>) => (result :: <v3>)
  make(<v3>,
       x: a.v-y * b.v-z - a.v-z * b.v-y,
       y: a.v-z * b.v-x - a.v-x * b.v-z,
       z: a.v-x * b.v-y - a.v-y * b.v-x)
end;

define method unit?
    (v :: <v3>) => (is-unit :: <boolean>)
  magnitude(v) = 1.0
end;

define method zero?
    (v :: <v3>) => (zero? :: <boolean>)
  v.v-x.zero? & v.v-y.zero? & v.v-z.zero?
end;

define method normalize
    (v :: <v3>) => (normalized :: <v3>)
  v / magnitude(v)
end;

define constant unitize = normalize;

define method distance
    (a :: <v3>, b :: <v3>) => (n :: <float>)
  magnitude(a - b)
end;

