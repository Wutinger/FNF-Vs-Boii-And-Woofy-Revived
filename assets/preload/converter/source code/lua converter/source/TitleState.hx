package;

import Song.SwagSong;
import openfl.Lib;
import Song.SwagSong;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.system.ui.FlxSoundTray;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import openfl.Assets;
import flixel.FlxSubState;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import openfl.events.IOErrorEvent;
import openfl.events.IOErrorEvent;
import openfl.net.FileReference;
import openfl.utils.ByteArray;
using StringTools;
import haxe.Json;

#if sys
import sys.io.File;
import sys.FileSystem;
#end

class TitleState extends MusicBeatState
{
	var _file:FileReference;
	static var initialized:Bool = false;

	var blackScreen:FlxSprite;


	override public function create():Void
	{

		super.create();

		//NGio.noLogin(APIStuff.API);
		startIntro();

		FlxG.save.bind('ek', 'bruhj');

		if (FlxG.save.data.volume != null)
			FlxG.sound.volume = FlxG.save.data.volume;

	}

	var logoBl:FlxSprite;
	var gfDance:FlxSprite;
	var danceLeft:Bool = false;
	var titleText:FlxSprite;

	var textThing:FlxText;

	static var mania:Int = 0;
	static var maniaConvert = [0, 6, 7, 8, 0, 3, 1, 4, 5, 2];
	

	var SONG:SwagSong = null;

	function startIntro()
	{
		FlxG.sound.playMusic(Paths.music('freakyMenu'), 0.7);

		Conductor.changeBPM(102);
		persistentUpdate = true;

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

		textThing = new FlxText(0,0,0,"Drag and drop your chart to convert!", 32);
		textThing.screenCenter();
		add(textThing);

		Application.current.window.onDropFile.add(function (path:String)
		{
			#if sys
			var rawJson = File.getContent(path).trim();
			while (!rawJson.endsWith("}"))
			{
				rawJson = rawJson.substr(0, rawJson.length - 1);
			}
			var swagShit:SwagSong = cast Json.parse(rawJson).song;
			if (swagShit.validScore == false)
				swagShit.validScore = true;

			SONG = swagShit;
			openSubState(new SelectionSubState('list', function(name:String)
				{
					var keyAmmo = Std.parseInt(name.charAt(0));
					trace(keyAmmo);
					mania = maniaConvert[keyAmmo];
					saveLevel();
				}, '',['1K','2K','3K','4K','5K','6K','7K','8K','9K']));		
			#end
		});

		// credGroup.add(credTextShit);
	}

	
	override function update(elapsed:Float)
	{
		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;
		// FlxG.watch.addQuick('amp', FlxG.sound.music.amplitude);

		

		super.update(elapsed);
	}

	

	override function beatHit()
	{
		super.beatHit();

		if (logoBl != null)
			logoBl.animation.play('bump');

		
	}

	function onSaveComplete(_):Void
	{
		_file.removeEventListener(Event.COMPLETE, onSaveComplete);
		_file.removeEventListener(Event.CANCEL, onSaveCancel);
		_file.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
		_file = null;
		FlxG.log.notice("Successfully saved LEVEL DATA.");
	}

	/**
	 * Called when the save file dialog is cancelled.
	 */
	function onSaveCancel(_):Void
	{
		_file.removeEventListener(Event.COMPLETE, onSaveComplete);
		_file.removeEventListener(Event.CANCEL, onSaveCancel);
		_file.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
		_file = null;
	}

	/**
	 * Called if there is an error while saving the gameplay recording.
	 */
	function onSaveError(_):Void
	{
		_file.removeEventListener(Event.COMPLETE, onSaveComplete);
		_file.removeEventListener(Event.CANCEL, onSaveCancel);
		_file.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
		_file = null;
		FlxG.log.error("Problem saving Level data");
	}
	function luaChartConvert(chart:SwagSong) //for an extra keys script i made for psych lol
	{
		var dataConverts:Array<Array<Int>> = [
			[0, 1, 2, 3,  4, 5, 6, 7],
			[0, 2, 3, 0, 1, 3,  4, 6, 7, 4, 5, 7],
			[0, 1, 2, 3, 2, 0, 1, 2, 3,  4, 5, 6, 7, 6, 4, 5, 6, 7],
			[0, 1, 2, 2, 3,  4, 5, 6, 6, 7],
			[0, 2, 3, 2, 0, 1, 3,   4, 6, 7, 6, 4, 5, 7],
			[0, 1, 2, 3, 0, 1, 2, 3,  4, 5, 6, 7, 4, 5, 6, 7],
			[2,6],
			[0,1,4,7],
			[0,2,3,4,6,7]
		];
		var nTypeConverts:Array<Array<String>> = [
			[null, null, null, null,null, null, null, null],
			[null, null, null, "Extras", null, "Extras",null, null, null, "Extras", null, "Extras"],
			[null, null, null, null, "Space", "Extras", "Extras", "Extras", "Extras",null, null, null, null, "Space", "Extras", "Extras", "Extras", "Extras"],
			[null, null, "Space", null, null,null, null, "Space", null, null],
			[null, null, null, "Space", "Extras", null, "Extras",null, null, null, "Space", "Extras", null, "Extras"],
			[null, null, null, null, "Extras", "Extras", "Extras", "Extras",null, null, null, null, "Extras", "Extras", "Extras", "Extras"],
			["Space","Space"],
			[null,null,null,null],
			[null,"Space",null,null,"Space",null]
		];
		for (sections in chart.notes)
		{
			for (daNote in sections.sectionNotes)
			{
				//trace(nTypeConverts[SONG.mania][daNote[1]]);
				daNote[3] = nTypeConverts[mania][daNote[1]]; //do note type first cuz data gets changed after
				daNote[1] = dataConverts[mania][daNote[1]];
				
			}
		}
		return chart;
	}

	private function saveLevel()
	{
		var json = {
			"song": SONG
		};

		var shit = Json.stringify({ //doin this so it doesnt act as a reference
			"song": SONG
		});
		var thing:SwagSong = Song.parseJSONshit(shit);

		thing = luaChartConvert(thing);			

		json = {
			"song": thing
		};

		var data:String = Json.stringify(json, "\t");

		if ((data != null) && (data.length > 0))
		{
			_file = new FileReference();
			_file.addEventListener(Event.COMPLETE, onSaveComplete);
			_file.addEventListener(Event.CANCEL, onSaveCancel);
			_file.addEventListener(IOErrorEvent.IO_ERROR, onSaveError);
			_file.save(data.trim(), SONG.song.toLowerCase() + ".json");
		}
	}


}
