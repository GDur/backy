backy
=====

Backy is a neural network which is using the backpropagation algorithm. (Written in Googles Dart). Please report all errors you can find to me.

How to
======
The Neuron
The neuron defines how the output is computed and in what range...

The Neural Network:
=================
It can be instanciated with any number of layer dimensions. For example: [2, 3, 1]
which produces a net with 3 layers. The input layer has two inputs and the
output layer has 1 output neuron. The hidden layer has 3 neurons.

Train the network
=================
Use the "train"-method to tell the net what you expect from a certain input.
net.train(<input>, <expected>);

e.g. train an XOR network:
```dart
  net.train([-1, -1], [ 1]);
  net.train([-1,  1], [-1]);
  net.train([ 1, -1], [-1]);
  net.train([ 1,  1], [ 1]);
```

Use the Network
=================
Once the network is trained, you can use it and it will return the output:
```dart
<expected> = net.use(<input>);

print(net.use([-1, 1])); // prints probably: [-.9988, .9988]
```

A working example:
=================
The network needs usually many trainingsteps in orderto find the right weights and therefore the solution.
Use the trainer in order to train backy more comfortably.

1. Imagine the trainer as a personal trainer for a student.
2. You tell the trainer what he should train the student.
3. And he will repeat the training until the student produces the expected answers, or until a maximum of trainingrounds has been exceeded.

```dart
// 1.
  var neuron  = new TanHNeuron(); // returnes floatingpoint values between -1 and 1
  var student = new Backy([2, 2, 1], neuron);
  var trainer = new Trainer(backy: student, maximumReapeatingCycle: 200, precision: .1);

// 2. Add the pattern whcih the network should learn
  trainer.addTrainingCase([-1,-1], [-1]);
  trainer.addTrainingCase([-1, 1], [-1]);
  trainer.addTrainingCase([ 1,-1], [-1]);
  trainer.addTrainingCase([ 1, 1], [ 1]);

// 3. train all the traininCases up to 300 times and be satisfied with a precision of .1
  print(trainer.trainOnlineSets()); // prints number loops it took to learn all trainingcases

// 4. After that you can use the neural network
  print(student.use([-1,-1]));
  print(student.use([-1, 1]));
  print(student.use([ 1,-1]));
  print(student.use([ 1, 1]));
```