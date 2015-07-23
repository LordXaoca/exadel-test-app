package com.exadel.test.views {
	import com.exadel.test.GalleryEvent;

	import robotlegs.bender.bundles.mvcs.Mediator;

	public class ImagePreviewMediator extends Mediator {

		[Inject]
		public var view : ImagePreviewView;

		override public function initialize() : void {
			super.initialize();

			addViewListener(GalleryEvent.LOAD_PHOTO, dispatch);
			addContextListener(GalleryEvent.ASSET_REMOVED, onAssetRemoved);
		}

		private function onAssetRemoved(event : GalleryEvent) : void {
			if (view.vo == event.data) {
				view.destroy();
			}
		}
	}
}
