package com.exadel.test.models {
	import com.exadel.test.GalleryEvent;

	import flash.events.IEventDispatcher;

	public class AppModel {
		public var previewWidth : int;
		public var previewHeight : int;
		public var photoWidth : int;
		public var photoHeight : int;

		[Inject]
		public var dispatcher : IEventDispatcher;

		private var _assets : Vector.<AssetVO>;

		public function AppModel() {
			_assets = new <AssetVO>[];
		}

		public function get assets() : Vector.<AssetVO> {
			return _assets;
		}

		public function addAsset(vo : AssetVO) : void {
			var index : Number = _assets.indexOf(vo);
			if (index == -1) {
				_assets.push(vo);
				dispatcher.dispatchEvent(new GalleryEvent(GalleryEvent.ASSET_ADDED, vo));
			}
		}

		public function removeAsset(vo : AssetVO) : void {
			var index : Number = _assets.indexOf(vo);
			if (index != -1) {
				_assets.splice(index, 1);
				dispatcher.dispatchEvent(new GalleryEvent(GalleryEvent.ASSET_REMOVED, vo));
			}
		}
	}
}
