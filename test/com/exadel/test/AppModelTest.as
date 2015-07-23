package com.exadel.test {
	import com.exadel.test.models.AppModel;

	import flash.events.EventDispatcher;

	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;

	public class AppModelTest {

		private var _appModel : AppModel;

		[Before]
		public function before() : void {
			_appModel = new AppModel();
			_appModel.dispatcher = new EventDispatcher();
		}

		[Test]
		public function defaultStateClean() : void {
			assertThat(_appModel.assets.length, equalTo(0));
		}

		[Test]
		public function assetsAddsCorrectly() : void {
			_appModel.addAsset(new MockAssetVO());
			assertThat(_appModel.assets.length, equalTo(1));
		}

		[Test]
		public function assetsRemovedCorrectly() : void {
			var vo : MockAssetVO = new MockAssetVO();
			_appModel.addAsset(vo);
			_appModel.removeAsset(vo);
			assertThat(_appModel.assets.length, equalTo(0));
		}

		[Test]
		public function modelFiltersDuplicates() : void {
			var vo : MockAssetVO = new MockAssetVO();
			_appModel.addAsset(vo);
			_appModel.addAsset(vo);
			assertThat(_appModel.assets.length, equalTo(1));
		}

		[Test(async)]
		public function modelNotifiesThatElementAdded() : void {
			var vo : MockAssetVO = new MockAssetVO();
			Async.proceedOnEvent(this, _appModel.dispatcher, GalleryEvent.ASSET_ADDED, 100);
			_appModel.addAsset(vo);
		}

		[Test(async)]
		public function modelNotifiesThatElementRemoved() : void {
			var vo : MockAssetVO = new MockAssetVO();
			_appModel.addAsset(vo);
			Async.proceedOnEvent(this, _appModel.dispatcher, GalleryEvent.ASSET_REMOVED, 100);
			_appModel.removeAsset(vo);
		}
	}
}
import com.exadel.test.models.AssetVO;

class MockAssetVO extends AssetVO {

	function MockAssetVO() {
		super(new XML());
	}
}