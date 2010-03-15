//AS3///////////////////////////////////////////////////////////////////////////
// 
// Copyright 2010 Sean Hellwig.
// seanhellwig@gmail.com
////////////////////////////////////////////////////////////////////////////////

package {
    import flash.display.Sprite;
    import flash.display.Loader;
    import flash.events.Event;
    import flash.events.ProgressEvent;
	import flash.text.TextFormat;
    import flash.net.URLRequest;

	import com.seanhellwig.preloaders.CirclePreloader;

	[SWF(width="650", height="650", backgroundColor="#FFFFFF", frameRate="30")]
    public class CircleLoaderExample extends Sprite {
    		private var _loader:Loader = new Loader();
			private var _loaderTF:TextFormat;
			private var _circleLoader:CirclePreloader;
    		private static const RADIUS:int = 300;
			
			//test image found on google images, using it because it is large in filesize.
    		private static const TEST_IMAGE:String = "http://mms.space.swri.edu/MMSposter-large.jpg";

		
        public function CircleLoaderExample() {	

			_loaderTF = new TextFormat();
			_loaderTF.size = 125;
			
			_circleLoader = new CirclePreloader(0x000000, 25, 1.0, RADIUS, true, _loaderTF);
			this.addChild(_circleLoader);
        	_loader.contentLoaderInfo.addEventListener(Event.OPEN, onOpen);
        	_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
        	_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			//extra url query string added for no caching purposes
        	_loader.load(new URLRequest(TEST_IMAGE+"?"+new Date().toString()));
        
            
        }
        
        private function onOpen(e:Event):void{
        		_circleLoader.reset();
				
				trace("init");
        		
        }
        
        
      	private function onProgress(e:ProgressEvent):void {
			_circleLoader.update(e.bytesLoaded, e.bytesTotal);
      	}
      	
      	
      	private function onComplete(e:Event):void{
			trace("load completed");
      	}
    }
}