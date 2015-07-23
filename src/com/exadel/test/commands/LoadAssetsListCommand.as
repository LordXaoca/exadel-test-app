package com.exadel.test.commands {
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	import br.com.stimuli.loading.IAssetsLoader;
	import br.com.stimuli.loading.IAssetsManager;

	import com.exadel.test.models.AppData;
	import com.exadel.test.models.AppModel;
	import com.exadel.test.models.AssetVO;

	import eu.alebianco.robotlegs.utils.impl.AsyncCommand;

	public class LoadAssetsListCommand extends AsyncCommand {

		[Inject]
		public var model : AppModel;
		[Inject]
		public var loader : IAssetsLoader;
		[Inject]
		public var assetsManager : IAssetsManager;

		override public function execute() : void {
			super.execute();

			loader.addEventListener(BulkProgressEvent.COMPLETE, onConfigLoadHandler);
			loader.add(AppData.CONFIG_PATH);
			loader.start();
		}

		override protected function dispatchComplete(success : Boolean) : void {
			loader.removeEventListener(BulkProgressEvent.COMPLETE, onConfigLoadHandler);

			super.dispatchComplete(success);
		}

		private function onConfigLoadHandler(event : BulkProgressEvent) : void {
			parseData();
			dispatchComplete(true);
		}

		private function parseData() : void {
			var data : XML = assetsManager.getXML(AppData.CONFIG_PATH);
			model.previewWidth = data.attribute("preview-width");
			model.previewHeight = data.attribute("preview-height");
			model.photoWidth = data.attribute("photo-height");
			model.photoHeight = data.attribute("photo-height");

			for each (var childData : XML in data.*) {
				model.addAsset(new AssetVO(childData));
			}
		}
	}
}
