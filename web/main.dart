part of backy;

void main() {

  var neuron = new TanHNeuron();
  var net = new Backy([2, 2, 1], neuron);


  var trainer = new Trainer(net);

  if(neuron is TanHNeuron) {
    trainer.addTrainingCase([-1,-1], [-1]);
    trainer.addTrainingCase([-1, 1], [ 1]);
    trainer.addTrainingCase([ 1,-1], [ 1]);
    trainer.addTrainingCase([ 1, 1], [-1]);

    //trainer.trainNewOnlineSets([[[-1, -1], [-1]], [[-1, 1], [1]], [[1, -1], [1]], [[1, 1], [-1]]], 1000);
    trainer.trainOnlineSets(1000);
    //print(trainer);

    print(net);
    print(net.use([-1,-1]));
    print(net.use([-1, 1]));
    print(net.use([ 1,-1]));
    print(net.use([ 1, 1]));

  }

  if(neuron is SigmoidNeuron){
    for(num i = 0; i < 10000; i++) {
      net.trainOnline([ 0, 0], [ 0]);
      net.trainOnline([ 0, 1], [ 1]);
      net.trainOnline([ 1, 0], [ 1]);
      net.trainOnline([ 1, 1], [ 0]);
    }
    print(net);
    print(net.use([ 0, 0]));
    print(net.use([ 0, 1]));
    print(net.use([ 1, 0]));
    print(net.use([ 1, 1]));
  }
}