package br.com.stimuli.loading {
	import br.com.stimuli.loading.loadingtypes.LoadingItem;

	import flash.events.IEventDispatcher;

	public interface IAssetsLoader extends IEventDispatcher{
		/** Adds a new assets to be loaded. The <code>BulkLoader</code> object will manage diferent assets type. If the right type cannot be infered from the url termination (e.g. the url ends with ".swf") the BulkLoader will relly on the <code>type</code> property of the <code>props</code> parameter. If both are set, the <code>type</code>  property of the props object will overrite the one defined in the <code>url</code>. In case none is specified and the url won't hint at it, the type <code>TYPE_TEXT</code> will be used.
		 *
		 *   @param url String OR URLRequest A <code>String</code> or a <code>URLRequest</code> instance.
		 *   @param props An object specifing extra data for this loader. The following properties are supported:<p/>
		 *   <table>
		 *       <th>Property name</th>
		 *       <th>Class constant</th>
		 *       <th>Data type</th>
		 *       <th>Description</th>
		 *       <tr>
		 *           <td>preventCache</td>
		 *           <td><a href="#PREVENT_CACHING">PREVENT_CACHING</a></td>
		 *           <td><code>Boolean</code></td>
		 *           <td>If <code>true</code> a random query string will be added to the url (or a post param in case of post reuquest).</td>
		 *       </tr>
		 *       <tr>
		 *           <td>id</td>
		 *           <td><a href="#ID">ID</a></td>
		 *           <td><code>String</code></td>
		 *           <td>A string to identify this item. This id can be used in any method that uses the <code>key</code> parameter, such as <code>pause, removeItem, resume, getContent, getBitmap, getBitmapData, getXML, getMovieClip and getText</code>.</td>
		 *       </tr>
		 *       <tr>
		 *           <td>priority</td.
		 *           <td><a href="#PRIORITY">PRIORITY</a></td>
		 *           <td><code>int</code></td>
		 *           <td>An <code>int</code> used to order which items till be downloaded first. Items with a higher priority will download first. For items with the same priority they will be loaded in the same order they've been added.</td>
		 *       </tr>
		 *       <tr>
		 *           <td>maxTries</td.
		 *           <td><a href="#MAX_TRIES">MAX_TRIES</a></td>
		 *           <td><code>int</code></td>
		 *           <td>The number of retries in case the lading fails, defaults to 3.</td>
		 *       </tr>
		 *       <tr>
		 *           <td>weight</td.
		 *           <td><a href="#WEIGHT">WEIGHT</a></td>
		 *           <td><code>int</code></td>
		 *           <td>A number that sets an arbitrary relative size for this item. See #weightPercent.</td>
		 *       </tr>
		 *       <tr>
		 *           <td>headers</td.
		 *           <td><a href="#HEADERS">HEADERS</a></td>
		 *           <td><code>Array</code></td>
		 *           <td>An array of <code>RequestHeader</code> objects to be used when constructing the URL. If the <code>url</code> parameter is passed as a string, <code>BulkLoader</code> will use these request headers to construct the url.</td>
		 *       </tr>
		 *       <tr>
		 *           <td>context</td.
		 *           <td><a href="#CONTEXT">CONTEXT</a></td>
		 *           <td><code>LoaderContext or SoundLoaderContext</code></td>
		 *           <td>An object definig the loading context for this load operario. If this item is of <code>TYPE_SOUND</code>, a <code>SoundLoaderContext</code> is expected. If it's a <code>TYPE_IMAGE</code> a LoaderContext should be passed.</td>
		 *       </tr>
		 *       <tr>
		 *           <td>pausedAtStart</td.
		 *           <td><a href="#PAUSED_AT_START">PAUSED_AT_START</a></td>
		 *           <td><code>Boolean</code></td>
		 *           <td>If true, the nestream will be paused when loading has begun.</td>
		 *       </tr>
		 *   </table>
		 *   You can use string substitutions (variable expandsion).
		 *   @example Retriving contents:<listing version="3.0">
		 import br.stimuli.loaded.BulkLoader;
		 var bulkLoader : BulkLoader = new BulkLoader("main");
		 // simple item:
		 bulkLoader.add("config.xml");
		 // use an id that can be retirved latterL
		 bulkLoader.add("background.jpg", {id:"bg"});
		 // or use a static var to have auto-complete and static checks on your ide:
		 bulkLoader.add("background.jpg", {BulkLoader.ID:"bg"});
		 // loads the languages.xml file first and parses before all items are done:
		 public function parseLanguages() : void{
   var theLangXML : XML = bulkLoader.getXML("langs");
   // do something wih the xml:
   doSomething(theLangXML);
}
		 bulkLoader.add("languages.xml", {priority:10, onComplete:parseLanguages, id:"langs"});
		 // Start the loading operation with only 3 simultaneous connections:
		 bulkLoader.start(3)
		 </listing>
		 *    @see #stringSubstitutions
		 *
		 */
		function add(url : *, props : Object = null) : LoadingItem;

		/** Start loading all items added previously
		 *   @param  withConnections [optional]The maximum number of connections to make at the same time. If specified, will override the parameter passed (if any) to the constructor.
		 *   @see #numConnections
		 *   @see #see #BulkLoader()
		 */
		function start(withConnections : int = -1) : void;

		/** Forces the item specified by key to be reloaded right away. This will stop any open connection as needed.
		 *   @param key The url request, url as a string or a id  from which the asset was created.
		 *   @return <code>True</code> if an item with that key is found, <code>false</code> otherwise.
		 */
		function reload(key : *) : Boolean;

		/** Forces the item specified by key to be loaded right away. This will stop any open connection as needed.
		 *   If needed, the connection to be closed will be the one with the lower priority. In case of a tie, the one
		 *   that has more bytes to complete will be removed. The item to load now will be automatically be set the highest priority value in this BulkLoader instance.
		 *   @param key The url request, url as a string or a id  from which the asset was created.
		 *   @return <code>True</code> if an item with that key is found, <code>false</code> otherwise.
		 */
		function loadNow(key : *) : Boolean;

		/**
		 *   The ratio (0->1) of items to load / items total.
		 *   This number is always reliable.
		 **/
		function get loadedRatio() : Number;

		/**
		 *   Number of items alrealdy loaded.
		 *   Failed or canceled items are not taken into consideration
		 */
		function get itemsLoaded() : int;

		function set itemsLoaded(value : int) : void;

		/** The sum of weights in all items to load.
		 *   Each item's weight default to 1
		 */
		function get totalWeight() : int;

		/** The total bytes to load.
		 *   If the number of items to load is larger than the number of simultaneous connections, bytesTotal will be 0 untill all connections are opened and the number of bytes for all items is known.
		 *   @see #bytesTotalCurrent
		 */
		function get bytesTotal() : int;

		/** The sum of all bytesLoaded for each item.
		 */
		function get bytesLoaded() : int;

		/** The sum of all bytes loaded so far.
		 *  If itemsTotal is less than the number of connections, this will be the same as bytesTotal. Else, bytesTotalCurrent will be available as each loading is started.
		 *   @see #bytesTotal
		 */
		function get bytesTotalCurrent() : int;

		/** The percentage (0->1) of bytes loaded.
		 *   Until all connections are opened  this number is not reliable . If you are downloading more items than the number of simultaneous connections, use loadedRatio or weightPercent instead.
		 *   @see #loadedRatio
		 *   @see #weightPercent
		 */
		function get percentLoaded() : Number;

		/** The weighted percent of items loaded(0->1).
		 *   This always returns a reliable value.
		 */
		function get weightPercent() : Number;

		/** A boolean indicating if the instace has started and has not finished loading all items
		 */
		function get isRunning() : Boolean;

		function get isFinished() : Boolean;

		/** Returns the highest priority for all items in this BulkLoader instance. This will check all items,
		 *   including cancelled items and already downloaded items.
		 */
		function get highestPriority() : int;

		/** Stop loading the item identified by <code>key</code>. This will not remove the item from the <code>BulkLoader</code>. Note that progress notification will jump around, as the stopped item will still count as something to load, but it's byte count will be 0.
		 * @param key The key (url as a string, url as a <code>URLRequest</code> or an id as a <code>String</code>).
		 * @param loadsNext If it should start loading the next item.
		 * @return A <code>Boolean</code> indicating if the object has been stopped.
		 */
		function pause(key : *, loadsNext : Boolean = false) : Boolean;

		/** Stops loading all items of this <code>BulkLoader</code> instance. This does not clear or remove items from the qeue.
		 */
		function pauseAll() : void;

		/** Resumes loading of the item. Depending on the environment the player is running, resumed items will be able to use partialy downloaded content.
		 *   @param  key The url request, url as a string or a id  from which the asset was loaded.
		 *   @return If a item with that key has resumed loading.
		 */
		function resume(key : *) : Boolean;

		/** Resumes all loading operations that were stopped.
		 *   @return <code>True</code> if any item was stopped and resumed, false otherwise
		 */
		function resumeAll() : Boolean;
	}
}
