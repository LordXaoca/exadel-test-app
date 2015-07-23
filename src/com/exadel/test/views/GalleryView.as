package com.exadel.test.views {
	import com.exadel.test.models.AssetVO;
	import com.greensock.TweenMax;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class GalleryView extends Sprite {

		private var _preloader : PreloaderView;
		private var _photo : ImageViewerView;

		public function GalleryView() {
			var overlay : DisplayObject = addChild(new View_Overlay());
			overlay.x = -108;
			overlay.y = -76;
		}

		public function addImage(vo : AssetVO) : void {
			var preview : ImagePreviewView = new ImagePreviewView(vo);
			// we make offset from sides
			preview.x = preview.width + int(Math.random() * (stage.stageWidth - preview.width * 2));
			preview.y = preview.height + int(Math.random() * (stage.stageHeight - preview.height * 2));
			preview.rotation = Math.random() * 720;
			preview.addEventListener(MouseEvent.ROLL_OVER, onPreviewOver);
			preview.addEventListener(MouseEvent.ROLL_OUT, onPreviewOut);
			preview.addEventListener(Event.CLEAR, onPreviewClear);
			addChild(preview);

			TweenMax.from(preview, 0.5, {
				x       : stage.stageWidth - preview.width >> 1,
				y       : stage.stageHeight - preview.height >> 1,
				rotation: 0,
				alpha   : 0,
				delay   : Math.random()
			});
		}

		private function onPreviewOver(event : MouseEvent) : void {
			addChild(event.currentTarget as DisplayObject);
		}

		private function onPreviewOut(event : MouseEvent) : void {

		}

		public function showPreloader() : void {
			hidePreloader();
			_preloader = new PreloaderView();
			addChild(_preloader);
		}

		public function hidePreloader() : void {
			_preloader && _preloader.destroy();
			_preloader = null;
		}

		public function showPhoto(vo : AssetVO) : void {
			_photo && _photo.destroy();
			_photo = new ImageViewerView(vo);
			addChild(_photo);
		}

		private function onPreviewClear(event : Event) : void {
			var preview : ImagePreviewView = event.currentTarget as ImagePreviewView;
			preview.removeEventListener(MouseEvent.ROLL_OVER, onPreviewOver);
			preview.removeEventListener(MouseEvent.ROLL_OUT, onPreviewOut);
			preview.removeEventListener(Event.CLEAR, onPreviewClear);
			TweenMax.killTweensOf(preview);
		}
	}
}
