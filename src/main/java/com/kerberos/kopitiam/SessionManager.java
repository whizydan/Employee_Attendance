/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.kerberos.kopitiam;

/**
 *
 * @author kerberos
 */
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class SessionManager {

    public static void createSession(HttpServletRequest request, String attributeName, Object attributeValue) {
        HttpSession session = request.getSession();
        session.setAttribute(attributeName, attributeValue);
    }

    public static Object getSessionAttribute(HttpServletRequest request, String attributeName) {
        HttpSession session = request.getSession();
        if (session != null) {
            return session.getAttribute(attributeName);
        }
        return null;
    }


    public static void removeSessionAttribute(HttpServletRequest request, String attributeName) {
        HttpSession session = request.getSession();
        session.removeAttribute(attributeName);
    }

    public static void invalidateSession(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.invalidate();
    }
}
