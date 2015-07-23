/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 06/05/13 18.56
 *
 * Copyright © 2013 Alessandro Bianco
 */
package robotlegs.starling.bundles.mvcs {

	import robotlegs.bender.extensions.enhancedLogging.InjectableLoggerExtension;
	import robotlegs.bender.extensions.enhancedLogging.TraceLoggingExtension;
	import robotlegs.bender.extensions.eventCommandMap.EventCommandMapExtension;
	import robotlegs.bender.extensions.eventDispatcher.EventDispatcherExtension;
	import robotlegs.bender.extensions.localEventMap.LocalEventMapExtension;
	import robotlegs.bender.extensions.vigilance.VigilanceExtension;
	import robotlegs.bender.framework.api.IBundle;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.LogLevel;
	import robotlegs.starling.extensions.contextView.StarlingContextViewExtension;
	import robotlegs.starling.extensions.contextView.StarlingContextViewListenerConfig;
	import robotlegs.starling.extensions.contextView.StarlingStageSyncExtension;
	import robotlegs.starling.extensions.mediatorMap.StarlingMediatorMapExtension;
	import robotlegs.starling.extensions.viewManager.StarlingManualStageObserverExtension;
	import robotlegs.starling.extensions.viewManager.StarlingStageCrawlerExtension;
	import robotlegs.starling.extensions.viewManager.StarlingStageObserverExtension;
	import robotlegs.starling.extensions.viewManager.StarlingViewManagerExtension;

	public class StarlingBundle implements IBundle {
    public function extend(context:IContext):void {
        context.logLevel = LogLevel.DEBUG;

        context.install(
                TraceLoggingExtension,
                VigilanceExtension,
                InjectableLoggerExtension,
                StarlingContextViewExtension,
                EventDispatcherExtension,
//                ModularityExtension,
                EventCommandMapExtension,
                LocalEventMapExtension,
                StarlingViewManagerExtension,
                StarlingStageObserverExtension,
                StarlingManualStageObserverExtension,
                StarlingMediatorMapExtension,
                StarlingStageCrawlerExtension,
                StarlingStageSyncExtension);

        context.configure(StarlingContextViewListenerConfig);
    }
}
}
