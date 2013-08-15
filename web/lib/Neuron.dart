part of backy;

class Neuron {
  num learningRate = 0.5;
  num bias = 5;
  bool useXOR = !true;
  bool useTanh = true;

  Neuron() {
    print("Neuron is using: \nlearningRate: $learningRate\nbias: $bias\nuseTanh: $useTanh");
    //print("tanh(100) (0) (-100): " + tanh(100).toString() + "," + tanh(0).toString() + "," +  tanh(-100).toString());
    //print("sig(100) (0) (-100): " + sig(100).toString() + "," + sig(0).toString() + "," +  sig(-100).toString());
  }

  num initialWeights() {
    var random = new Math.Random();
    if(useTanh)
      return 1 - (random.nextDouble() * 2);
    return random.nextDouble();
  }

  num activation(num x) {
    if(useTanh)
      return tanh(x - bias);
    return sig(x - bias);
  }

  num derivative(num x){
    if(useTanh)
      return 1 - tanh(x) * tanh(x);
    return x * (1 - x);
  }

  String toString(){
    return "test: " + activation.toString();
  }

  num sig(num x){
    return 1 / (1 + Math.pow(Math.E, (-1 * x)));
  }

  num tanh(num x){
    return -1 + 2 / (1 + Math.pow(Math.E,(-2 * x)));
  }
}