package com.exadel.test.views {
	import com.exadel.test.models.AppModel;

	import flash.events.Event;

	import robotlegs.bender.bundles.mvcs.Mediator;

	public class ImageViewerMediator extends Mediator {

		[Inject]
		public var view : ImageViewerView;
		[Inject]
		public var model : AppModel;

		override public function initialize() : void {
			super.initialize();

			addViewListener(Event.CLOSE, onViewHide);
		}

		private function onViewHide(event : Event) : void {
			model.removeAsset(view.vo);
		}
	}
}
