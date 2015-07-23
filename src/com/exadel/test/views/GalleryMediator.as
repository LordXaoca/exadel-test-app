package com.exadel.test.views {
	import br.com.stimuli.loading.IAssetsManager;

	import com.exadel.test.GalleryEvent;
	import com.exadel.test.models.AppModel;
	import com.exadel.test.models.AssetVO;

	import robotlegs.bender.bundles.mvcs.Mediator;

	public class GalleryMediator extends Mediator {

		[Inject]
		public var view : GalleryView;
		[Inject]
		public var model : AppModel;
		[Inject]
		public var assetsManager : IAssetsManager;

		override public function initialize() : void {
			super.initialize();

			addContextListener(GalleryEvent.ASSETS_LOADED, onAssetsLoaded);
			addContextListener(GalleryEvent.SHOW_PRELOADER, onShowPreloader);
			addContextListener(GalleryEvent.HIDE_PRELOADER, onHidePreloader);
			addContextListener(GalleryEvent.SHOW_PHOTO, onShowPhoto);
			view.showPreloader();
		}

		private function onShowPhoto(event : GalleryEvent) : void {
			view.showPhoto(event.data);
		}

		private function onAssetsLoaded(event : GalleryEvent) : void {
			for each (var vo : AssetVO in model.assets) {
				view.addImage(vo);
			}
		}

		private function onShowPreloader(event : GalleryEvent) : void {
			view.showPreloader();
		}

		private function onHidePreloader(event : GalleryEvent) : void {
			view.hidePreloader();
		}
	}
}
