import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_keys.dart';

/// Service class for AI Chatbot integration
/// Supports both Gemini and Perplexity APIs
class ChatbotService {
  // Choose which API to use: 'gemini' or 'perplexity'
  static const String activeAPI = 'gemini';
  
  // Gemini API endpoint
  static const String geminiEndpoint = 
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent';
  
  // Perplexity API endpoint
  static const String perplexityEndpoint = 
      'https://api.perplexity.ai/chat/completions';

  // Send message to AI and get response
  static Future<String> sendMessage(String message, String siteName) async {
    try {
      if (activeAPI == 'gemini') {
        return await _sendToGemini(message, siteName);
      } else {
        return await _sendToPerplexity(message, siteName);
      }
    } catch (e) {
      print('❌ Error sending message: $e');
      return 'Sorry, I encountered an error. Please try again.';
    }
  }

  // Send message to Gemini API
  static Future<String> _sendToGemini(String message, String siteName) async {
    try {
      // Create context for the AI about the UNESCO site
      String contextualMessage = 
          'You are a knowledgeable guide about UNESCO World Heritage Sites in India. '
          'The user is asking about "$siteName". '
          'Please provide detailed, accurate, and engaging information. '
          'User question: $message';

      final response = await http.post(
        Uri.parse('$geminiEndpoint?key=${ApiKeys.geminiApiKey}'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': contextualMessage}
              ]
            }
          ],
          'generationConfig': {
            'temperature': 0.7,
            'topK': 40,
            'topP': 0.95,
            'maxOutputTokens': 1024,
          }
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        // Extract text from Gemini response
        if (data['candidates'] != null && data['candidates'].isNotEmpty) {
          final candidate = data['candidates'][0];
          if (candidate['content'] != null && 
              candidate['content']['parts'] != null &&
              candidate['content']['parts'].isNotEmpty) {
            return candidate['content']['parts'][0]['text'] ?? 
                   'Sorry, I could not generate a response.';
          }
        }
        
        return 'Sorry, I could not generate a response.';
      } else {
        print('❌ Gemini API Error: ${response.statusCode} - ${response.body}');
        return 'Sorry, I encountered an error connecting to the AI service.';
      }
    } catch (e) {
      print('❌ Gemini Error: $e');
      return 'Sorry, there was an error processing your request.';
    }
  }

  // Send message to Perplexity API
  static Future<String> _sendToPerplexity(String message, String siteName) async {
    try {
      // Create context for the AI about the UNESCO site
      String systemMessage = 
          'You are a knowledgeable guide about UNESCO World Heritage Sites in India. '
          'Provide detailed, accurate, and engaging information about "$siteName".';

      final response = await http.post(
        Uri.parse(perplexityEndpoint),
        headers: {
          'Authorization': 'Bearer ${ApiKeys.perplexityApiKey}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': 'llama-3.1-sonar-small-128k-online', // Perplexity model
          'messages': [
            {
              'role': 'system',
              'content': systemMessage,
            },
            {
              'role': 'user',
              'content': message,
            }
          ],
          'temperature': 0.7,
          'max_tokens': 1024,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        // Extract text from Perplexity response
        if (data['choices'] != null && data['choices'].isNotEmpty) {
          return data['choices'][0]['message']['content'] ?? 
                 'Sorry, I could not generate a response.';
        }
        
        return 'Sorry, I could not generate a response.';
      } else {
        print('❌ Perplexity API Error: ${response.statusCode} - ${response.body}');
        return 'Sorry, I encountered an error connecting to the AI service.';
      }
    } catch (e) {
      print('❌ Perplexity Error: $e');
      return 'Sorry, there was an error processing your request.';
    }
  }

  // Get suggested questions for a site
  static List<String> getSuggestedQuestions(String siteName) {
    return [
      'Tell me about the history of $siteName',
      'What is the architectural style of $siteName?',
      'When was $siteName built?',
      'What is the cultural significance of $siteName?',
      'What are the best times to visit $siteName?',
      'Are there any legends or stories about $siteName?',
    ];
  }
}
