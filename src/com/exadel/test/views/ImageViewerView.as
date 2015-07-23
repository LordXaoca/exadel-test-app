package com.exadel.test.views {
	import br.com.stimuli.loading.BulkLoader;

	import com.exadel.test.models.AssetVO;
	import com.greensock.TweenMax;

	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;

	public class ImageViewerView extends View_BigPhoto {
		private static const OFFSET : int = 20;

		private var _bitmap : Bitmap;
		private var _overlay : Overlay;
		private var _background : DisplayObject;
		private var _container : Sprite;

		private var _vo : AssetVO;

		public function ImageViewerView(vo : AssetVO) {
			_vo = vo;
			_overlay = new Overlay();
			_overlay.addEventListener(Event.CHANGE, onOverlayChange);
			addChild(_overlay);

			var loader : BulkLoader = BulkLoader.getLoader("default");
			_bitmap = loader.getBitmap(_vo.photoPath, true);
			_bitmap.x = _bitmap.y = OFFSET;

			_background = getChildByName("background");
			_background.width = _bitmap.width + OFFSET * 2;
			_background.height = _bitmap.height + OFFSET * 2;

			var closeButton : Sprite = getChildByName("closeButton") as Sprite;
			closeButton.useHandCursor = true;
			closeButton.x = _background.width;
			closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClick);

			_container = new Sprite();
			_container.filters = [new DropShadowFilter(5, 45, 0x333333, 1, 5, 5, 1, 3)];
			_container.addChild(_background);
			_container.addChild(_bitmap);
			_container.addChild(closeButton);
			addChild(_container);

			show();
		}

		public function get vo() : AssetVO {
			return _vo;
		}

		public function show() : void {
			TweenMax.from(this, 0.5, {alpha: 0});
		}

		public function hide() : void {
			mouseEnabled = mouseChildren = false;
			TweenMax.to(this, 0.5, {alpha: 0, onComplete: destroy});
		}

		public function destroy() : void {
			TweenMax.killTweensOf(this);
			if (_bitmap) {
				_container.removeChild(_bitmap);
				_bitmap.bitmapData.dispose();
				_bitmap.bitmapData = null;
				_bitmap.loaderInfo.loader.unloadAndStop();
				_bitmap = null;
			}
			if (_overlay) {
				_overlay.removeEventListener(Event.CHANGE, onOverlayChange);
				_overlay.destroy();
				_overlay = null;
			}
			if (parent) {
				parent.removeChild(this);
			}
		}

		private function onCloseButtonClick(event : MouseEvent) : void {
			hide();
			dispatchEvent(new Event(Event.CLOSE));
		}

		private function onOverlayChange(event : Event) : void {
			_container.x = _overlay.width - _background.width >> 1;
			_container.y = _overlay.height - _background.height >> 1;
		}
	}
}
