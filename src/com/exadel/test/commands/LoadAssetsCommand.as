package com.exadel.test.commands {
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	import br.com.stimuli.loading.IAssetsLoader;

	import com.exadel.test.models.AppModel;
	import com.exadel.test.models.AssetVO;

	import eu.alebianco.robotlegs.utils.impl.AsyncCommand;

	public class LoadAssetsCommand extends AsyncCommand {

		[Inject]
		public var model : AppModel;
		[Inject]
		public var loader : IAssetsLoader;

		override public function execute() : void {
			super.execute();

			loader.addEventListener(BulkProgressEvent.COMPLETE, onAllImagesLoadedHandler);

			for each (var vo : AssetVO in model.assets) {
				loader.add(vo.previewPath);
			}
			loader.start();
		}

		private function onAllImagesLoadedHandler(event : BulkProgressEvent) : void {
			dispatchComplete(true);
		}

		override protected function dispatchComplete(success : Boolean) : void {
			loader.removeEventListener(BulkProgressEvent.COMPLETE, onAllImagesLoadedHandler);

			super.dispatchComplete(success);
		}
	}
}
