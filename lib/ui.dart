import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube/main.dart';
import 'package:youtube/viewmode.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<YouTubeViewModel>(context);

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'YOUTUBE SEARCH',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                ),
                onPressed: () {
                  themeProvider.toggleTheme();
                },
              ),
            ],
            leading: Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                "https://upload.wikimedia.org/wikipedia/commons/e/ef/Youtube_logo.png",
                fit: BoxFit.contain,
              ),
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onSubmitted: (query) {
                    viewModel.searchVideos(query);
                  },
                  decoration: const InputDecoration(
                    hintText: 'Search for videos...',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              Expanded(
                child: viewModel.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: viewModel.videos.length,
                        itemBuilder: (context, index) {
                          final video = viewModel.videos[index];
                          final isDarkMode =
                              Theme.of(context).brightness == Brightness.dark;
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isDarkMode
                                    ? Colors.white
                                    : Colors.grey[900],
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      video.thumbnailUrl,
                                      fit: BoxFit.cover, // Adjusted fit
                                      width: double.infinity,
                                      height: 200, // Set a fixed height
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        video.title,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                video.thumbnailUrl),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            video.channelName,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          const Spacer(),
                                          if (video.live)
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 4),
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: const Text(
                                                'LIVE',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        video.description,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            video.length,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          const Spacer(),
                                          if (video.watching > 0)
                                            Text(
                                              '${video.watching} watching',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              )
            ],
          ),
        );
      },
    );
  }
}
