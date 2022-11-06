using Godot;
using System;
using System.IO.Compression;

public class zipper : Node
{
	public void Zip(String filePath, String zipPath, String zipName) 
	{
		string zipPathFull = zipPath +"\\"+zipName;
		ZipFile.CreateFromDirectory(filePath, zipPathFull);
	}

	public void Unzip(String zipPath, String extractPath) 
	{
		ZipFile.ExtractToDirectory(zipPath, extractPath);
		
//		[ON-HOLD] If given time, I'll try to make a zip modifier. 
//				  As of now, it is too time consuming.
//		ZipArchive zipFile = ZipFile.OpenRead(zipPath);
//		foreach (ZipArchiveEntry zip in zipFile.Entries)
//		{
//			GD.Print("Zipfile: ", zip.FullName, " ", zip.Length, "MB");
//		}
	}
}
