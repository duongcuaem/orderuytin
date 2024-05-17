package com.mrChill.Relax.Utils;

import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

public class FileUtils {
    public static String FOLDER_IMAGE = "/Users/macbook/Desktop/orderuytin/imgOrderuytin/";
    public static String saveFile(MultipartFile file) {
        File folder = new File(FOLDER_IMAGE);
        if (!folder.exists()) folder.mkdirs();
        Path path = Paths.get(FOLDER_IMAGE);
        try {
            String fileImage = System.currentTimeMillis() + file.getOriginalFilename();
            Files.copy(file.getInputStream(), path.resolve(fileImage));
            return fileImage;
        } catch (Exception e) {

        }
        return "";
    }
}
