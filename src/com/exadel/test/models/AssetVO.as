package com.exadel.test.models {
	public class AssetVO {
		private var _photoPath : String;
		private var _previewPath : String;
		private var _title : String;

		public function AssetVO(data : XML) {
			_photoPath = data.@photo;
			_previewPath = data.@preview;
			_title = data.@title;
		}

		public function get title() : String {
			return _title;
		}

		public function get previewPath() : String {
			return _previewPath;
		}

		public function get photoPath() : String {
			return _photoPath;
		}
	}
}
