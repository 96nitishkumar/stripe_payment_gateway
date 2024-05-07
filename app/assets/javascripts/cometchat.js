// Initialize CometChat
CometChat.init({
  appId: '2570581f6274020a',
  apiKey: '7b68a408c7ccf541a2639db8f0547a3da7e91031',
  region: 'in'
});

document.addEventListener('DOMContentLoaded', function() {
  const chatWidget = new CometChat.Widget({
    widgetID: '67168bb2-ac7e-42a2-a71c-039827f72bad',
    target: '#chatContainer',
    config: {
      // Configuration options for the chat widget
    }
  });

  chatWidget.render();
});
