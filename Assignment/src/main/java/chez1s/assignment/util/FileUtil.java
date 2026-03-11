package chez1s.assignment.util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

public final class FileUtil {
    private static final String UPLOAD_DIR = "uploads";

    public static String upload(HttpServletRequest request, String name) {
        try {
            Part part = request.getPart(name);
            if (part == null || part.getSize() <= 0) return "";
            
            String fileName = part.getSubmittedFileName();
            if (fileName == null || fileName.isEmpty()) return "";
            
            String ext = fileName.substring(fileName.lastIndexOf("."));
            String uniqueName = System.currentTimeMillis() + ext;
            
            String uploadPath = request.getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();
            
            Path filePath = Path.of(uploadPath, uniqueName);
            Files.copy(part.getInputStream(), filePath);
            
            return uniqueName;
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }

    public static boolean delete(HttpServletRequest request, String fileName) {
        if (fileName == null || fileName.isEmpty()) return false;
        String uploadPath = request.getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File file = new File(uploadPath, fileName);
        return file.exists() && file.isFile() && file.delete();
    }
}
