part of backy;

num sig(num x) =>  1.0 / (1.0 + Math.pow(Math.E, -x));
num tanh(num x) => -1.0 + 2.0 / (1 + Math.pow(Math.E,(-2 * x)));

class TanHNeuron implements Neuron {
  num learningRate = .7;
  num bias = 5;
  TanHNeuron(){print(this);}

  num initialWeights() => 1 - (new Math.Random().nextDouble() * 2);

  num activation(num networth) => tanh(networth - bias);

  num derivative(num output) => 1 - tanh(output) * tanh(output);
}

class SigmoidNeuron implements Neuron {
  // works requires a lot of trainings
  num learningRate = 5.1;
  num bias = -5.8;

  SigmoidNeuron() {print(this); }

  num initialWeights() => .5 - new Math.Random().nextDouble();

  num activation(num networth) => sig(networth - bias);

  num derivative(num output) => (output) * (1 - (output));
}

class RectifierNeuron implements Neuron {
  // doesnt work yet bugfix required
  num learningRate = .9;
  num bias = 1.8;

  RectifierNeuron() {print(this); }

  num initialWeights() => .5 - new Math.Random().nextDouble();

  num activation(num networth) => Math.log(1 + Math.pow(Math.E, networth - bias));

  num derivative(num output) => sig(output - bias);
}

abstract class Neuron {
  num learningRate;
  num bias;

  // creates usually random a random weight suitable for the specific neuron
  num initialWeights();

  // networth to output
  num activation(num networth);

  num derivative(num outputs);
}