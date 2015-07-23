package com.exadel.test {
	import flash.events.Event;

	public class GalleryEvent extends Event {

		public static const SHOW_PRELOADER : String = "showPreloader";
		public static const HIDE_PRELOADER : String = "hidePreloader";

		/**
		 * All assets for all VOs are loaded.
		 */
		public static const ASSETS_LOADED : String = "assetsLoaded";
		public static const LOAD_PHOTO : String = "loadPhoto";
		public static const SHOW_PHOTO : String = "showPhoto";
		public static const ASSET_REMOVED : String = "assetRemoved";

		/**
		 * VO added to list, assets stil not loaded.
		 */
		public static const ASSET_ADDED : String = "assetAdded";

		private var _data : *;

		public function GalleryEvent(type : String, data : * = null) {
			super(type);

			_data = data;
		}

		public function get data() : * {
			return _data;
		}

		public function set data(value : *) : void {
			_data = value;
		}

		public override function clone() : Event {
			return new GalleryEvent(type, data);
		}

		public override function toString() : String {
			return formatToString("GalleryEvent", "type", "data", "bubbles", "cancelable", "eventPhase");
		}

	}
}
