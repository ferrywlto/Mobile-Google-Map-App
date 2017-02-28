package
{
	import com.google.maps.InfoWindowOptions;
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.google.maps.Map;
	import com.google.maps.MapEvent;
	import com.google.maps.MapMouseEvent;
	import com.google.maps.MapOptions;
	import com.google.maps.MapType;
	import com.google.maps.overlays.Marker;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.events.FlexEvent;
	
	import spark.components.Application;
	import spark.components.Panel;
	import spark.core.SpriteVisualElement;
	
	public class Main extends Application
	{
		protected var map:Map;
		protected var mainPanel:Panel;
		protected var mapSprite:SpriteVisualElement;
		
		public function Main()
		{
			addEventListener(FlexEvent.CREATION_COMPLETE, App_CREATION_COMPLETE);
		}
			
		private function App_CREATION_COMPLETE(event:FlexEvent):void
		{	
			trace("waiting google...");
			
			mainPanel = new Panel();
			mainPanel.title = "Google Map Test App";
			mainPanel.width = width;
			mainPanel.height = height;
			
			mapSprite = new SpriteVisualElement();
			mapSprite.width = mainPanel.width;
			mapSprite.height = mainPanel.height;
			
			map = new Map();
			map.key = "";
			map.sensor = "true";
			map.url = ""
			map.addEventListener(MapEvent.MAP_PREINITIALIZE, map_onPreInit);
			map.addEventListener(MapMouseEvent.CLICK, map_onClick);
			mapSprite.addChild(map);
			mainPanel.addElement(mapSprite);
			addElement(mainPanel);
		}
		
		public function map_onPreInit(event:MapEvent):void 
		{
			trace("map inited");
			var options:MapOptions;
			with(options = new MapOptions()) 
			{
				center = new LatLng(22.33419832350944,114.13421630859375);
				zoom = 14;
				mapType = MapType.NORMAL_MAP_TYPE;
			}
			map.width = mainPanel.width;
			map.height = mainPanel.height;
			map.setInitOptions(options);
		}
		
		private function map_onClick(event:com.google.maps.MapMouseEvent):void 
		{
			var latlng:LatLng = event.latLng;
			mainPanel.title = new Date().toTimeString() +"- lat:"+latlng.lat()+" lng:"+latlng.lng();
			map.panTo(latlng);
		}
	}
}
