package org.jok.flex.utility.math
{
	public class ExtendedMath
	{
		public function ExtendedMath()
		{
		}
		
		public static function round(n : Number, radix : Number) : Number {
			var result : Number = n;
			var factor : Number = Math.pow(10,Math.abs(radix));
			var remain : Number;
			if (radix>0) {
				remain = result % factor;
				if (Math.abs(remain)>=(factor/2)) {
					return roundup(n,radix);
				} else {
					return rounddown(n,radix);
				}
			} else {
				result = Math.round(result * factor);
				result = result / factor;
			}
			
			return result;
		}
		
		public static function roundup(n : Number, radix : Number) : Number {
			var result : Number = n;
			var factor : Number = Math.pow(10,Math.abs(radix));
			var remain : Number;
			if (radix>0) {
				remain = result % factor;
				result = Math.round((result-remain) / factor) * factor;
				if (remain!=0) {
					result = result + (result>=0?factor:-factor);
				}
			} else {
				result = Math.round(result * factor);
				result = result / factor;
			}
			
			return result;
		}
		
		public static function rounddown(n : Number, radix : Number) : Number {
			var result : Number = n;
			var factor : Number = Math.pow(10,Math.abs(radix));
			var remain : Number = result % factor;
			if (radix>0) {
				result = Math.round((result-remain) / factor) * factor;
			} else {
				result = Math.round((result-remain) * factor);
				result = result / factor;
			}
			return result;
		}
	}
}