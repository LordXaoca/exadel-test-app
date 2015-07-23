package robotlegs.starling.extensions.eventMap {
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IExtension;

	/**
	 * StarlingViewEventMapExtension class.
	 *
	 * @author: Ivan Shaban
	 * @date: 26.09.13 15:09
	 */

	public class StarlingViewEventMapExtension implements IExtension {

		public function extend(context : IContext) : void {
			context.injector.map(IStarlingViewEventMap).toType(StarlingViewEventMap);
		}
	}
}
