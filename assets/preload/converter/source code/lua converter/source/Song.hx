package;

import Section.SwagSection;
import haxe.Json;
import haxe.format.JsonParser;
import lime.utils.Assets;



#if sys
import sys.io.File;
import sys.FileSystem;
#end

using StringTools;

typedef SwagSong =
{
	var song:String;
	var notes:Array<SwagSection>;
	var bpm:Float;
	var needsVoices:Bool;
	var speed:Float;
	var mania:Int;

	var player1:String;
	var player2:String;
	var gfVersion:String;
	var stage:String;
	var validScore:Bool;

	var showGFStrums:Bool;

	var instSuffix:String;
	var vocalsSuffix:String;
	var displayName:String;

	var audioFromUrl:Bool;
	var instUrl:String;
	var vocalsUrl:String;


}

class Song
{
	public var song:String;
	public var notes:Array<SwagSection>;
	public var bpm:Float;
	public var needsVoices:Bool = true;
	public var speed:Float = 1;
	public var mania:Int = 0;

	public var player1:String = 'bf';
	public var player2:String = 'dad';
	public var gfVersion:String = '';
	public var stage:String = '';
	public var showGFStrums:Bool = false;

	public var instSuffix:String = '';
	public var vocalsSuffix:String = '';
	public var displayName:String = '';

	public var audioFromUrl:Bool = false;
	public var instUrl:String = '';
	public var vocalsUrl:String = '';

	public function new(song, notes, bpm)
	{
		this.song = song;
		this.notes = notes;
		this.bpm = bpm;
	}

	public static function loadFromJson(jsonInput:String, ?folder:String, freeplay:Bool = false):SwagSong
	{

		#if sys
		var rawJson = File.getContent(Paths.json(folder.toLowerCase() + '/' + jsonInput.toLowerCase(), freeplay)).trim();
		#else
		var rawJson = Assets.getText(Paths.json(folder.toLowerCase() + '/' + jsonInput.toLowerCase(), false)).trim();
		#end

		/*#if sys
		if (Note.MaxNoteData > 9) //to anyone that wants to add more keys, please dont.
			rawJson = File.getContent(Paths.json(folder.toLowerCase() + '/' + "Fuck You")).trim(); // :troll:
		#end*/

		while (!rawJson.endsWith("}"))
		{
			rawJson = rawJson.substr(0, rawJson.length - 1);
			// LOL GOING THROUGH THE BULLSHIT TO CLEAN IDK WHATS STRANGE
		}

		// FIX THE CASTING ON WINDOWS/NATIVE
		// Windows???
		// trace(songData);

		// trace('LOADED FROM JSON: ' + songData.notes);
		/* 
			for (i in 0...songData.notes.length)
			{
				trace('LOADED FROM JSON: ' + songData.notes[i].sectionNotes);
				// songData.notes[i].sectionNotes = songData.notes[i].sectionNotes
			}

				daNotes = songData.notes;
				daSong = songData.song;
				daBpm = songData.bpm; */

		return parseJSONshit(rawJson);
	}

	public static function parseJSONshit(rawJson:String):SwagSong
	{
		var swagShit:SwagSong = cast Json.parse(rawJson).song;
		if (swagShit.validScore == false)
			swagShit.validScore = true;

		return swagShit;
	}
}
