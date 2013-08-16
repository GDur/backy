part of backy;

class TanHNeuron implements Neuron {
  num learningRate = .5;
  num bias = 5;

  TanHNeuron() {print(this); }

  num initialWeights() => 1 - (new Math.Random().nextDouble() * 2);

  num activation(num x) => tanh(x - bias);

  num derivative(num x) => 1 - tanh(x) * tanh(x);

  num tanh(num x) => -1 + 2 / (1 + Math.pow(Math.E,(-2 * x)));
}

class SigmoidNeuron implements Neuron {
  // doesn't work yet bugfix needed
  num learningRate = .5;
  num bias = 5;

  SigmoidNeuron() {print(this); }

  num initialWeights() => new Math.Random().nextDouble();

  num activation(num x) => sig(x - bias);

  num derivative(num x) => x * (1 - x);

  num sig(num x) =>  1 / (1 + Math.pow(Math.E, (-1 * x)));
}

abstract class Neuron {
  num learningRate;
  num bias;

  num initialWeights();
  num activation(num x);
  num derivative(num x);
}