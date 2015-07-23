package com.exadel.test.views {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	[Event(name="change", type="flash.events.Event")]
	public class Overlay extends Sprite {
		private var _bitmapData : BitmapData;
		private var _blurFilter : BlurFilter;
		private var _filterRect : Rectangle;

		public function Overlay() {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function initOverlay() : void {
			_blurFilter = new BlurFilter(10, 10, 3);
			_filterRect = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			_bitmapData = new BitmapData(stage.stageWidth, stage.stageHeight, false, 0x666666);
			addChild(new Bitmap(_bitmapData));
		}

		public function destroy() : void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

			_bitmapData && _bitmapData.dispose();
			_bitmapData = null;
			_blurFilter = null;
			_filterRect = null;

			if (parent) {
				parent.removeChild(this);
			}
		}

		public function updateOverlay() : void {
			if (stage) {
				parent.visible = false;
				_bitmapData.draw(stage);
				_bitmapData.applyFilter(_bitmapData, _filterRect, new Point(), _blurFilter);
				parent.visible = true;
				dispatchEvent(new Event(Event.CHANGE));
			} else {
				throw IllegalOperationError("You cannot update overlay while it not in display list.");
			}
		}

		private function onAddedToStage(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

			initOverlay();
			updateOverlay();
		}
	}
}
