package ;
import sys.FileSystem;
import sys.io.File;

/**
 * ...
 * @author Goh Zi He
 */
class RunScript
{
	private static inline var ZE2D_VERSION:String = "0.1.9";

	public function new()
	{
		var args:Array<String> = Sys.args();
		switch (args.length)
		{
			case 2:
				switch (args[0])
				{
					case "list":
						showAllCommands();
					case "version":
						printVersion();
					default:
						showAllCommands();
				}
			case 4:
				switch (args[0])
				{
					case "new":
						createNewProject(args[1], args[2]);
					default:
						showAllCommands();
				}
			
			default:
				showAllCommands();
		}
		
		echo("");
	}
	
	function createNewProject(projectName:String, projectDirectory:String):Void
	{
		var template = FileSystem.fullPath("template\\");
		var newProjectPath = projectDirectory + projectName;
		
		FileSystem.createDirectory(newProjectPath);
		copy(template, newProjectPath);
		FileSystem.rename(newProjectPath + "\\Template.hxproj", newProjectPath + "\\" + projectName + ".hxproj");
		
		echo(projectName + " was created at " + newProjectPath);
	}
	
	function copy(filePath:String, directory:String)
	{
		for (file in FileSystem.readDirectory(filePath))
		{
			if (FileSystem.isDirectory(filePath + file))
			{
				copy(filePath + file + "\\", directory + "\\" + file);
			}
			else
			{
				if (!FileSystem.exists(directory))
				{
					FileSystem.createDirectory(directory);
				}
				File.copy(filePath + file, directory + "\\" + file);
			}
		}
	}
	
	
	function showAllCommands()
	{
		Sys.command("cls");
		echo("");
		echo("Welcome to ZE2D command line tool.");
		echo("Type haxelib run ze2d list to see all commands.");
		echo("");
		echo("    Usage: haxelib run ze2d [argument]                          ");
		echo("                                                                ");
		echo("    Available Commands:                                         ");
		echo("    list - List All commands.                                   ");
		echo("    new - Create a new project with path you specify.           ");
		echo("    version - Show current version of ZE2D.                     ");
		echo("                                                                ");
		echo("    E.g. haxelib run ze2d new MyProjectName C:\\Projects\\      ");
		echo("         will create a MyProjectName folder at C:\\Projects\\   ");
	}
	
	function printVersion():Void
	{
		echo("Version: " + ZE2D_VERSION);
	}
	
	function echo(v:Dynamic):Void
	{
		Sys.println(v);
	}
}