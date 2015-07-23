package com.exadel.test.views {
	import br.com.stimuli.loading.BulkLoader;

	import com.exadel.test.GalleryEvent;
	import com.exadel.test.models.AssetVO;

	import flash.display.Bitmap;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;

	[Event(name="clear", type="flash.events.Event")]
	public class ImagePreviewView extends Sprite {
		private static const PHOTO_OFFSET : int = 5;
		private static const FILTERS : Array = [new DropShadowFilter(2, 45, 0x333333, 1, 4, 4, 1.5, 3)];

		private var _vo : AssetVO;
		private var _bitmap : Bitmap;
		private var _isDragged : Boolean;

		public function ImagePreviewView(vo : AssetVO) {
			_vo = vo;
			var loader : BulkLoader = BulkLoader.getLoader("default");
			_bitmap = loader.getBitmap(vo.previewPath, true);
			_bitmap.x = _bitmap.y = PHOTO_OFFSET;

			addChild(_bitmap);
			cacheAsBitmap = true;
			addEventListener(MouseEvent.MOUSE_DOWN, onPress);
			addEventListener(MouseEvent.CLICK, onClick);
			filters = FILTERS;
			useHandCursor = true;

			var g : Graphics = graphics;
			g.beginFill(0xFFFFFF);
			g.drawRect(0, 0, _bitmap.width + PHOTO_OFFSET * 2, _bitmap.height + PHOTO_OFFSET * 2);
			g.endFill();
		}

		public function get vo() : AssetVO {
			return _vo;
		}

		private function onPress(event : MouseEvent) : void {
			alpha = 0.6;
			startDrag();
			addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}

		private function onClick(event : MouseEvent) : void {
			removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			alpha = 1;
			stopDrag();

			if (_isDragged) {
			} else {
				dispatchEvent(new GalleryEvent(GalleryEvent.LOAD_PHOTO, _vo));
			}
			_isDragged = false;
		}

		private function onMouseMove(event : MouseEvent) : void {
			_isDragged = true;
			removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}

		public function destroy() : void {
			dispatchEvent(new Event(Event.CLEAR));
			removeEventListener(MouseEvent.MOUSE_DOWN, onPress);
			removeEventListener(MouseEvent.CLICK, onClick);
			removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			stopDrag();
			filters = null;

			if (_bitmap) {
				removeChild(_bitmap);
				_bitmap.bitmapData.dispose();
				_bitmap.bitmapData = null;
				_bitmap.loaderInfo.loader.unloadAndStop();
				_bitmap = null;
			}
			if (parent) {
				parent.removeChild(this);
			}
		}
	}
}
