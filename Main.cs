using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class Main : MonoBehaviour
{

	// Use this for initialization
	void Start ()
	{
		
		
		
		
		// {bool: usweBias, double:bias, function:logistic, function:derivativeOfLogistic} as Abstract class CoreSpecs
		NNBackpropagation nn = new NNBackpropagation (new int[]{ 2, 1});
		int i = 0;
		
		while (true) {
			if (i > 100)
				break;
			nn.train (new double[]{ 1, 1}, new double[]{1});
			nn.train (new double[]{ 0, 1}, new double[]{0});
			nn.train (new double[]{ 1, 0}, new double[]{0});
			nn.train (new double[]{ 0, 0}, new double[]{0});
		
		
			//if (equals (nn.use (new double[]{ 1, 1}) [0], 1) && equals (nn.use (new double[]{ 0, 0}) [0], 0))
				//break;
			i++;
		}
		double a = nn.use (new double[]{ 1, 1})[0];
		double b = nn.use (new double[]{ 1, 0})[0];
		double c = nn.use (new double[]{ 0, 1})[0];
		double d = nn.use (new double[]{ 0, 0})[0];
		
		Debug.Log (" a: " + a  + " b: " + b  + " c: " + c+ " d: " + b + " ... " + i);
		
		nn.showStats();
		
		/*
		if (false) {
			for (int i =0; i < 4; i++) {
				nn.train (new double[]{ 0.2, 0.2}, new double[]{0.7});
			}
			List<double> a = nn.use (new double[]{ 0.2, 0.2});
			Debug.Log ("a: " + a [0] + "");
		} else {
			int i = 0;
		
			double expected = 1;
			double expected2 = 0;
		
			while (true) {
				nn.train (new double[]{ 1, 1}, new double[]{0});
				nn.train (new double[]{ 0, 1}, new double[]{1});
				nn.train (new double[]{ 1, 0}, new double[]{1});
				nn.train (new double[]{ 0, 0}, new double[]{0});
				if (i > 2000)
					break;
			
				if (equals (nn.use (new double[]{ 1, 1}) [0], 0) && equals (nn.use (new double[]{ 0, 0}) [0], 0))
					break;
				i++;
			}
			List<double> a = nn.use (new double[]{ 1, 1});
			List<double> b = nn.use (new double[]{ 0, 1});
			List<double> c = nn.use (new double[]{ 1, 0});
			List<double> d = nn.use (new double[]{ 0, 0});
			Debug.Log (" a: " + a [0] + " b: " + b [0] + " c: " + c [0] + " d: " + d [0] + "  " + i);
			
			nn.showStats();
			
		}*/
	}
	
	bool equals (double a, double b)
	{
		double range = 0.02;
		if ((a > b - range) && (a < b + range))
			return true;
		return false;
	}
	// Update is called once per frame
	void Update ()
	{
	}
}
