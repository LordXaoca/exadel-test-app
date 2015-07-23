package com.exadel.test {
	import com.exadel.test.views.GalleryView;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	import robotlegs.bender.bundles.mvcs.MVCSBundle;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.impl.Context;

	[SWF(width="1024", height="768", frameRate="30", backgroundColor="#666666")]
	public class Root extends Sprite {

		private var _context : IContext;

		public function Root() {
			if (stage) {
				initialize();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, initialize);
			}
		}

		private function initialize(event : Event = null) : void {
			removeEventListener(Event.ADDED_TO_STAGE, initialize);

			initStage();
			initGallery();
			initRobotLegs();
		}

		private function initStage() : void {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.stageFocusRect = false;
		}

		private function initRobotLegs() : void {
			_context = new Context();
			_context.afterInitializing(onRLInitializeComplete)
					.install(MVCSBundle)
					.configure(GalleryConfig)
					.configure(new ContextView(this));
		}

		private function onRLInitializeComplete() : void {
			var dispatcher : IEventDispatcher = _context.injector.getInstance(IEventDispatcher);
			dispatcher.dispatchEvent(new Event(Event.INIT));
		}

		private function initGallery() : void {
			addChild(new GalleryView());
		}
	}
}
