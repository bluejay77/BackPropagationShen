\*

The backpropagation program main file


AJY 2020-03-12 -->

The NN backpropagation learning
Russell-Norvig AIMA 3rd edition fig. 18.24 p. 734
The book "AIMA" == Artificial Intelligence, A Modern Approach

The interactive mode (Haykin, 1999):


Corrected by Dr A. J. Y:

1 the algorithm was fixed as above;

2 the deltas are a 2D array, one delta element for each network neuron;
Every delta element could contain a Shen object, a neuron;

3 every element of the 2D deltas array, contains the changes vector
for the changes to the weights of this deltas neuron;

4 the randomization of the examples, and more, fixes carried out
by the author;

For certain technical reasons, the author did not use the Shen types.

Use:

(load "ld.shen")




function back-prop-learning(ex, net, NI, NO) returns a net
inputs: ex, a set of examples, each w/ input vector x(i)
 & output vector y(i)
net, a multilayer network w/ L layers, weights w(i,j),
activation function g()
The variable net is a 2D array, its element (k,l) == the neuron #k,l.
Every element in the array net is a data structure = a neuron, the neuron
has her weights w(i,j) = the weight from neuron #i to the neuron #j
NI the number of inputs to the net
NO the number of the outputs of the net
local variables: delta, a vector of errors, indexed by network node(k,l)
alpha is the learning constant, exemplaris gratis = 0.1

for each weight w(i,j,k,l) in the network net, do
    w(i,j,k,l) <- a small random number
    od

\\ Actually --> the neuron #(i,j) and her weight #(i,j,k,l)
\\ The weight of the neuron #(i,j), from the neuron k to the neuron l
\\ id est, the arc in the net from the neuron k to the neuron l

repeat
    rearrange the examples into a random order ==> ex1;
    for each example (x,y) in ex1 do
        // Propagate the inputs forward to compute the outputs
        for each node i in the input layer do
            a(i) <- x(i) ; Assign the values in the example ==> neurons
            for l = 2 to l do
                for each node j in layer i do ; Fire all neurons
                    in(j) <- SIGMA[i] w(i,j) * a(i)
                    a(j) <- g(in(j)) ; The activation function
        // Propagate deltas backward from output layer to input layer
        for each node j in the output layer do
            delta(L,j) <- g'(in(j)) * (y(j) - a(j)) ; Output layer deltas
        for l = L-1 downto 1 do ; Backpropagate deltas L-1st ==> 1st
            for each node i  in layer j do
                delta(l,i) <- g'(in(i)) SIGMA[j] w(i,j) * delta(l,j)
        // Update every weight in network using deltas
        for each weight w(i,j,k,l) in network do ; Correct with the deltas
            w(i,j,k,l) <- w(i,j,k,l) + alpha * a(i,j,k,l) * delta(i,j,k,l)

until (stopping criterion is satisfied)

return net

*\

(set *iterCounter* 0)
(set *iterations* 10)


(define repeat-back-prop
    EX NET G NI NO NEX
    ->
    (do
        (repeat-back-prop-body)
	(if (repeat-condition-back-prop)
	    (do
	        (repeat-back-prop-body)
	    	(repeat-back-prop EX NET G NI NO NEX))
	    [])))


(define repeat-condition-back-prop
    -> (<= (value *iterCounter*) (value *iterations*)))

(set *iterCounter* 0)

(set *iterations* 100)

(define repeat-back-prop-body
    -> 	
        (let
	    \\ rearrange the examples into a random order ==> ex1;
	    EX-1 0 \\ (rearrange-ex EX)
	    L 5 \\ the number of the layers
	    NODES 1 \\the number of the nodes in this layer
	    NEX 10
	    \\ for each example (x,y) in ex1 do
	    Ign (set *NEXA* NEX)
            Ignore3
		    (for (Exm 1 1 NEX)
		        (do
		        \\ Propagate the inputs forward to compute the outputs
		        \\ for each node i in the input layer do
		        \\  a(i) <- x(i)
		        \\ Assign the values in the example #Example ==> neurons
		        (for (Layer 2 1 L)
		            (for (Node 1 1 NODES)
			        \\ for each node j in layer i do
			        \\ Fire all neurons
			        (let
			            \\ in(j) <- SIGMA[i] w(i,j) * a(i)
				    \\ a(j) <- g(in(j)) ; activation function
				[])))
		        \\ Propagate deltas backward
		        \\ from output layer to input layer
                        \\ Phase #1.
		        \\ for each node j in the output layer do
			\\ delta(L,J)
			\\     <- g'(in(j)) * (y(j) - a(j))
			\\ Output layer deltas
			(for-function-output-deltas)
			\\ Phase #2. Deltas for the hidden layers.
			(for-minus-function-backpropagate-hidden)
			\\ Inside the above function call,
		        \\ Backpropagate deltas #l-1st ==> #1st
			\\ for each each node i in layer l do
			\\ delta(l,i) <-
			\\     g'(in(i)) SIGMA[j] w(i,j) * delta(l,j)
                    \\ Update every weight in network using deltas
	            \\ for each weight w(i,j,k,l) in network do
	            \\ Correct with the deltas
                    \\ w(i,j,k,l) <- w(i,j,k,l) +
		    \\    ALPHA * a(i,j,k,l) * delta(i,j,k,l)
	          ) \\ end do
                (set *iterCounter* (+ 1 (value *iterCounter*)))
	        ) \\ end for loop, for all the training examples
	[]) \\ end let
) \\ end function



\*

The FOR X=A STEP B TO C

NEXT X

loop, with functions.

Dr Antti Juhani Ylikoski 2020-10-05

*\

\\ The FOR loop for handling all the examples, the training examples

(set *A1* 1)
(set *B1* 1)
(set *C1* 10)

(set *X1* (value *A1*))

(define for-function-ex
    ->
        (if (<= (value *X1*) (value *C1*))
	  (do
	    (for-function-body-ex)
	    (set *X1* (+ (value *X1*) (value *B1*)))
	    (for-function-ex))
	    []))


(define for-function-body-ex
    ->
    (output "~%~S" (value *X1*)))


\*

The FOR X=A STEP B TO C

NEXT X

loop, with functions.

Dr Antti Juhani Ylikoski 2020-10-05

*\

\\ The FOR loop for all the layers in the ANN

(set *A2* 0)
(set *B2* 2)
(set *C2* 16)

(set *X2* (value *A2*))

(define for-function-layers
    ->
        (if (<= (value *X2*) (value *C2*))
	  (do
	    (for-function-body-layers)
	    (set *X2* (+ (value *X2*) (value *B2*)))
	    (for-function-layers))
	    []))


(define for-function-body-layers
    ->
    (output "~%~S" (value *X2*)))



\*

The FOR X=A STEP B TO C

NEXT X

loop, with functions.

Dr Antti Juhani Ylikoski 2020-10-05

*\

\\ The FOR loop for all the nodes in this particular layer


(set *A3* 0)
(set *B3* 2)
(set *C3* 16)

(set *X3* (value *A3*))

(define for-function-nodes-layer
    ->
        (if (<= (value *X3*) (value *C3*))
	  (do
	    (for-function-body-nodes-layer)
	    (set *X3* (+ (value *X3*) (value *B3*)))
	    (for-function-nodes-layer))
	    []))


(define for-function-body-nodes-layer
    ->
    (output "~%~S" (value *X3*)))



\*

The FOR X=A STEP B TO C

NEXT X

loop, with functions.

Dr Antti Juhani Ylikoski 2020-10-05

*\

\\ Output layer deltas
\\ for each node j in the output layer do
\\ delta(j) <- g'(in(j)) * (y(j) - a(j))
\\ y(j) is the target output vector, the desired results
\\ a(j) is the activation function value, id est, the output #j
\\ in(j) = SIGMA[i=0 TO n] (w(i,j) * a(i))
\\ id est, the input of the activation function of the neuron #j



(set *A4* 0)
(set *B4* 2)
(set *C4* 16)

(set *X4* (value *A4*))

(define for-function-output-deltas
    ->
        (if (<= (value *X4*) (value *C4*))
	  (do
	    (for-function-body-output-deltas)
	    (set *X4* (+ (value *X4*) (value *B4*)))
	    (for-function-output-deltas))
	    []))


(define for-function-body-output-deltas
    ->
    (output "~%~S Output deltas" (value *X4*)))


\*

The FOR X=A STEP B DOWNTO C

NEXT X

loop, with functions.

NOTA BENE, with the negative increment.

Dr Antti Juhani Ylikoski 2020-10-05

*\


\\ The FOR loop for backpropagating over the layers
\\ #top level minus 1 --> #1
\\ Calculate the deltas

\\ The FOR loop for the deltas over a hidden layer, layer #l, neuron #i
\\ delta(l,i) <- g'(in(i)) SIGMA[j=1 TO #outputs] w(i,j) * delta(l,j)
\\ here the #j are her output neurons
\\ for each neuron #i in the layer #l


(set *A5* 20)
(set *B5* -1)
(set *C5* 0)

(set *X5* (value *A5*))

(define for-minus-function-backpropagate-hidden
    ->
        (if (>= (value *X5*) (value *C5*))
	  (do
	    (for-function-body-backpropagate-hidden)
	    (set *X* (+ (value *X5*) (value *B5*)))
	    (for-minus-function-backpropagate-hidden))
	    []))


(define for-function-body-backpropagate-hidden
    -> (do
           (for-function-sigma)
	   (output "~%~S SIGMA summing hidden layer sigma" (value *X5*))))


\*

The FOR X=A STEP B TO C

NEXT X

loop, with functions.

Dr Antti Juhani Ylikoski 2020-10-05

*\


(set *A0* 0)
(set *B0* 2)
(set *C0* 16)

(set *X0* (value *A0*))

(define for-function-sigma
    ->
        (if (<= (value *X0*) (value *C0*))
	  (do
	    (for-function-body-sigma)
	    (set *X0* (+ (value *X0*) (value *B0*)))
	    (for-function-sigma))
	    []))


(define for-function-body-sigma
    ->
    (output "~%~S SIGMA number" (value *X0*)))


\*

Try:

(for-function)

*\





\*

Update every weight in network using deltas for each weight w(i,j,k,l)
in network do Correct with the deltas

w(i,j,k,l) <- w(i,j,k,l) + ALPHA * a(i,j,k,l) * delta(i,j,k,l)

Traverse the whole neural network

*\

\*

The FOR X=A STEP B TO C

NEXT X

loop, with functions.

Dr Antti Juhani Ylikoski 2020-10-05

*\

\\ Update every weight, traverse every layer in the neural network


(set *A6* 0)
(set *B6* 2)
(set *C6* 16)

(set *X6* (value *A6*))

(define for-function-update-layer
    ->
        (if (<= (value *X6*) (value *C6*))
	  (do
	    (for-function-body-update-layer)
	    (set *X6* (+ (value *X6*) (value *B6*)))
	    (for-function-update-layer))
	    []))


(define for-function-body-update-layer
    ->
    (output "~%~S" (value *X6*)))


\*

Update every weight, update every individual neuron in the
neural network, in this particular layer

*\

\*

The FOR X=A STEP B TO C

NEXT X

loop, with functions.

Dr Antti Juhani Ylikoski 2020-10-05

*\


(set *A7* 0)
(set *B7* 2)
(set *C7* 16)

(set *X7* (value *A7*))

(define for-function-update-layer
    ->
        (if (<= (value *X7*) (value *C7*))
	  (do
	    (for-function-body-update-layer)
	    (set *X* (+ (value *X7*) (value *B7*)))
	    (for-function-update-layer))
	    []))


(define for-function-body-update-layer
    ->
    (output "~%~S" (value *X7*)))


\*

The FOR X=A STEP B TO C

NEXT X

loop, with functions.

Dr Antti Juhani Ylikoski 2020-10-05

*\

\\ Update every weight of this particular neuron


(set *A8* 0)
(set *B8* 2)
(set *C8* 16)

(set *X8* (value *A8*))

(define for-function-neuron
    ->
        (if (<= (value *X*) (value *C*))
	  (do
	    (for-function-body-neuron)
	    (set *X8* (+ (value *X8*) (value *B8*)))
	    (for-function-neuron))
	    []))


(define for-function-body-neuron
    ->
    (output "~%~S" (value *X8*)))






(define back-prop-learning \\ returns a net
    EX \\ a set of examples, each w/ input vector x(i)
       \\ & output vector y(i)
    NET \\  a multilayer network w/ L layers, weights w(i,j),
    G \\ activation function g()
    \\ The variable NET is a 2D array, its element (k,l) == the neuron #k,l.
    \\ Every element in the array net is a data structure = a neuron, the neuron
    \\ has her weights w(i,j) = the weight from neuron #i to the neuron #j
    NI \\ the number of inputs to the net
    NO \\ the number of the outputs of the net
    NEX \\ the number of the training examples
    ->
    (let
        \\ The Shen let is a sequential, not a functional construct
	\\ The literature ref has given the algorithm as a
	\\ sequential algortihm
	\\ local variables: delta,
	\\ a vector of errors, indexed by network node(k,l)
	ALPHA (value *ALPHA*)
	\\ alpha is the learning constant, exemplaris gratis = 0.1
	\\
	\\ for each weight w(i,j) in the network net, do
	\\     w(i,j) <- a small random number
	\\  od
	NET (vector 10) \\ (initialize-weights-random NET)
	\\ Actually --> the neuron #(i,j) and her weight #(i,j,k,l)
	\\ The weight of the neuron #(i,j), arc from the
	\\ neuron k to the neuron l
	\\ id est, the arc in the net from the neuron k to the neuron l
	Ignore2 (repeat-back-prop
	            EX
		    NET
		    G
		    NI
		    NO
		    NEX)
	[]))






(define demo
    ->
        (back-prop-learning
	    (vector 100)
	    (vector 1000)
	    []
	    10
	    2
	    1000
	    ))


