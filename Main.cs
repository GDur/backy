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
		if (false) {
			for (int i =0; i < 4; i++) {
				nn.train (new double[]{ 0.2, 0.2}, new double[]{0.7});
			}
			List<double> a = nn.use (new double[]{ 0.2, 0.2});
			Debug.Log ("a: " + a [0] + "");
		} else {
			int i = 0;
		
			double expected = 0.9;
			double expected2 = 0.1;
		
			while (true) {
				nn.train (new double[]{ 1, 1}, new double[]{expected});
				nn.train (new double[]{ 0.1, 0.1}, new double[]{expected2});
				if (i > 200)
					break;
			
				if (equals (nn.use (new double[]{ 1, 1}) [0], expected) && equals (nn.use (new double[]{ 0.1, 0.1}) [0], expected2))
					break;
				i++;
			}
			List<double> a = nn.use (new double[]{ 1, 1});
			List<double> b = nn.use (new double[]{ 0.1, 0.1});
			Debug.Log (a [0] + "a  " + b [0] + " a- " + i);
		}
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
