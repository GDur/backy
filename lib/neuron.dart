part of backy;

num sig(num x) =>  1.0 / (1.0 + Math.pow(Math.E, -x));
num tanh(num x) => -1.0 + 2.0 / (1 + Math.pow(Math.E,(-2 * x)));

class TanHNeuron implements Neuron {
  num learningRate = .5;
  num bias = 5;

  TanHNeuron() {print(this); }

  num initialWeights() => 1 - (new Math.Random().nextDouble() * 2);

  num activation(num x) => tanh(x - bias);

  num derivative(num x) => 1 - tanh(x) * tanh(x);
}

class SigmoidNeuron implements Neuron {
  // doesn't work yet bugfix required
  num learningRate = 0.7;
  num bias = 5;

  SigmoidNeuron() {print(this); }

  num initialWeights() => new Math.Random().nextDouble();

  num activation(num x) => sig(x + bias);

  num derivative(num x) => x * (1 - x);
}

class RectifierNeuron implements Neuron {
  // doesnt work yet bugfix required
  num learningRate = .5;
  num bias = 5;

  RectifierNeuron() {print(this); }

  num initialWeights() => 1 - (new Math.Random().nextDouble() * 2);

  num activation(num x) => Math.log(1 + Math.pow(Math.E, x - bias));

  num derivative(num x) => sig(x - bias);
}

abstract class Neuron {
  num learningRate;
  num bias;

  num initialWeights();
  num activation(num x);
  num derivative(num x);
}