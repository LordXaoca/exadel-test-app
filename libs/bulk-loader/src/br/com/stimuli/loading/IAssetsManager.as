package br.com.stimuli.loading {
	import br.com.stimuli.loading.loadingtypes.LoadingItem;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public interface IAssetsManager {
		/** Checks if there is <b>loaded</b> item in this <code>BulkLoader</code>.
		 * @param    The url (as a <code>String</code> or a <code>URLRequest</code> object)or an id (as a <code>String</code>) by which the item is identifiable.
		 * @param    searchAll   If true will search through all <code>BulkLoader</code> instances. Else will only search this one.
		 * @return   True if a loader has a <b>loaded</b> item stored.
		 */
		function hasItem(key : *, searchAll : Boolean = true) : Boolean;

		/** Returns a copy of all <code>LoadingItem</code> in this intance. This function makes a copy to avoid
		 *   users messing with _items (removing items and so forth). Those can be done through functions in BulkLoader.
		 *   @return A array that is a shallow copy of all items in the BulkLoader.
		 */
		function get items() : Array;

		/** Total number of items to load.*/
		function get itemsTotal() : int;

		/** Returns an untyped object with the downloaded asset for the given key.
		 *   @param key The url request, url as a string or a id  from which the asset was loaded.
		 *   @param clearMemory If this <code>BulkProgressEvent</code> instance should clear all references to the content of this asset.
		 *   @return The content retrived from that url
		 */
		function getContent(key : String, clearMemory : Boolean = false) : *;

		/** Returns an XML object with the downloaded asset for the given key.
		 *   @param  key          String OR URLRequest     The url request, url as a string or a id  from which the asset was loaded. Returns null if the cast fails
		 *   @param clearMemory If this <code>BulkProgressEvent</code> instance should clear all references to the content of this asset.
		 *   @return The content retrived from that url casted to a XML object. Returns null if the cast fails.
		 */
		function getXML(key : *, clearMemory : Boolean = false) : XML;

		/** Returns a String object with the downloaded asset for the given key.
		 *   @param key The url request, url as a string or a id  from which the asset was loaded. Returns null if the cast fails
		 *   @param clearMemory If this <code>BulkProgressEvent</code> instance should clear all references to the content of this asset.
		 *   @return The content retrived from that url casted to a String object. Returns null if the cast fails.
		 */
		function getText(key : *, clearMemory : Boolean = false) : String;

		/** Returns a Bitmap object with the downloaded asset for the given key.
		 *   @param key The url request, url as a string or a id  from which the asset was loaded. Returns null if the cast fails
		 *   @param clearMemory If this <code>BulkProgressEvent</code> instance should clear all references to the content of this asset.
		 *   @return The content retrived from that url casted to a Bitmap object. Returns null if the cast fails.
		 */
		function getBitmap(key : String, clearMemory : Boolean = false) : Bitmap;

		/** Returns a Loader object with the downloaded asset for the given key.
		 * Had to pick this ugly name since <code>getLoader</code> is currently used for getting a BulkLoader instance.
		 * This is useful if you are loading images but do not have a crossdomain to grant you permissions. In this case, while you
		 * will still find restrictions to how you can use that loaded asset (no BitmapData for it, for example), you still can use it as content.
		 *
		 *   @param key The url request, url as a string or a id  from which the asset was loaded. Returns null if the cast fails
		 *   @param clearMemory If this <code>BulkProgressEvent</code> instance should clear all references to the content of this asset.
		 *   @return The content retrived from that url casted to a Loader object. Returns null if the cast fails.
		 */
		function getDisplayObjectLoader(key : String, clearMemory : Boolean = false) : Loader;

		/** Returns a <code>MovieClip</code> object with the downloaded asset for the given key.
		 *   @param key The url request, url as a string or a id  from which the asset was loaded. Returns null if the cast fails
		 *   @param clearMemory If this <code>BulkProgressEvent</code> instance should clear all references to the content of this asset.
		 *   @return The content retrived from that url casted to a MovieClip object. Returns null if the cast fails.
		 */
		function getMovieClip(key : String, clearMemory : Boolean = false) : MovieClip;

		/** Returns a <code>Sprite</code> object with the downloaded asset for the given key.
		 *   @param key The url request, url as a string or a id  from which the asset was loaded. Returns null if the cast fails
		 *   @param clearMemory If this <code>BulkProgressEvent</code> instance should clear all references to the content of this asset.
		 *   @return The content retrived from that url casted to a Sprite object. Returns null if the cast fails.
		 */
		function getSprite(key : String, clearMemory : Boolean = false) : Sprite;

		/** Returns an BitmapData object with the downloaded asset for the given key.
		 *   @param key The url request, url as a string or a id  from which the asset was loaded. Returns null if the cast fails. Does not clone the original bitmap data from the bitmap asset.
		 *   @param clearMemory If this <code>BulkProgressEvent</code> instance should clear all references to the content of this asset.
		 *   @return The content retrived from that url casted to a BitmapData object. Returns null if the cast fails.
		 */
		function getBitmapData(key : *, clearMemory : Boolean = false) : BitmapData;

		/** Used  to fetch an item with a given key. The returned <code>LoadingItem</code> can be used to attach event listeners for the individual items (<code>Event.COMPLETE, ProgressEvent.PROGRESS, Event.START</code>).
		 *   @param key A url (as a string or urlrequest) or an id to fetch
		 *   @return The corresponding <code>LoadingItem</code> or null if one isn't found.
		 */
		function get(key : *) : LoadingItem;

		/** This will delete this item from memory. It's content will be inaccessible after that.
		 *   @param key A url (as a string or urlrequest) or an id to fetch
		 *   @param internalCall If <code>remove</code> has been called internally. End user code should ignore this.
		 *   @return <code>True</code> if an item with that key has been removed, and <code>false</code> othersiwe.
		 *   */
		function remove(key : *, internalCall : Boolean = false) : Boolean;

		/** Deletes all loading and loaded objects. This will stop all connections and delete from the cache all of it's items (no content will be accessible if <code>removeAll</code> is executed).
		 */
		function removeAll() : void;
	}
}
