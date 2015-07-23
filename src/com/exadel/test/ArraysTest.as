package com.exadel.test {
	import flash.display.Sprite;

	public class ArraysTest extends Sprite{
		private var _arr1 : Vector.<int>;

		private var _arr2 : Vector.<int>;

		private var _arr3 : Vector.<int>;

		public function ArraysTest() {
			generateData();
			_arr3 = sortArray(_arr1, _arr2);
			testSort();
		}

		private function generateData() : void {
			var MAX_ELEMENTS_COUNT : int = 100;
			_arr1 = new <int>[];
			_arr2 = new <int>[];
			var n : int = Math.random() * MAX_ELEMENTS_COUNT;
			for (var i : int = 0; i < n; i++) {
				_arr1.push(i == 0 || Math.random() < 0.5 ? i : _arr1[_arr1.length - 1]);
			}
			n = Math.random() * MAX_ELEMENTS_COUNT;
			for (i = 0; i < n; i++) {
				_arr2.push(i == 0 || Math.random() < 0.5 ? i : _arr2[_arr2.length - 1]);
			}
			trace("arr 1:", _arr1);
			trace("arr 2:", _arr2);
		}

		private function sortArray(arr1 : Vector.<int>, arr2 : Vector.<int>) : Vector.<int> {
			var arr1Length : uint = arr1.length;
			var arr2Length : uint = arr2.length;
			var totalLength : int = arr1Length + arr2Length;
			var temp:Vector.<int> = new <int>[];
			for (var k : int = 0, m : int = 0; (k + m) < totalLength;) {
				if (m == arr2Length) {
					temp[temp.length - 1] = arr1[k++];
				} else if (k == arr1Length) {
					temp[temp.length - 1] = arr2[m++];
				} else if (arr1[k] < arr2[m]) {
					temp[temp.length - 1] = arr1[k++];
				} else if (arr1[k] > arr2[m]) {
					temp[temp.length - 1] = arr2[m++];
				} else {
					temp.push(arr1[k++], arr2[m++]);
				}
				trace("k", k, "m", m, "total:", totalLength);
			}
			trace("result:", temp, "| total length:", temp.length);
			return temp;
		}

		private function testSort() : void {
			var testPassed : Boolean = true;
			var n : int = _arr3.length;
			for (var i : int = 0; i < n; i++) {
				if (i > 0 && _arr3[i - 1] > _arr3[i]) {
					testPassed = false;
					break;
				}
			}
			if (testPassed) {
				trace("test passed");
			} else {
				trace("test failed!");
			}
		}
	}
}
