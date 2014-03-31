package ;
import sys.FileSystem;
import sys.io.File;

/**
 * ...
 * @author Goh Zi He
 */
class RunScript
{
	public function new()
	{
		var args:Array<String> = Sys.args();
		showAllCommands();
		
		switch (args[0])
		{
			case "new":
			createNewProject(args[1], args[2]);
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
		echo("    new - Create a new project with path you specify.           ");
		echo("                                                                ");
		echo("    E.g. haxelib run ze2d new MyProjectName C:\\Projects\\      ");
		echo("    E.g. haxelib run ze2d new MyProjectName 				      ");
	}
	
	function echo(v:Dynamic):Void
	{
		Sys.println(v);
	}
}