using Gtk;
using Gdk;
using Gst;
using Gee;

namespace Sounds {
  class Window : Gtk.Window {
    private HashMap<uint, bool> pressed;
    private HashMap<int, string> filenames;
    private HashMap<int, Element> pipelines;
  
    public Window () {
      int i;
      pressed = new HashMap<uint, bool>();
      filenames = new HashMap<int, string>();
      pipelines = new HashMap<int, Element>();
      
      var hbox = new Box(Gtk.Orientation.HORIZONTAL, 0);
      var filter = new FileFilter();
      filter.add_mime_type("audio/mp3");
      for (i = 0; i < 13; i++) {
        var chooser = new FileChooserButton("Choose a file for key " + "%d".printf(i), FileChooserAction.OPEN);
        chooser.set_filter(filter);
        hbox.pack_start(chooser, false, false, 6);
        chooser.file_set.connect(on_file_chosen);
      }
      
      hbox.set_margin_top(900);
      this.add(hbox);
      
      this.window_position = WindowPosition.CENTER;
      this.set_default_size(1000, 1000);

      this.add_events(Gdk.EventMask.BUTTON_RELEASE_MASK);
      this.button_press_event.connect(on_button_press);
      this.button_release_event.connect(on_button_release);
      this.key_press_event.connect(on_key_press);
      this.key_release_event.connect(on_key_release);
    }
    
    private bool on_button_press(Gdk.EventButton event) {
      switch(event.button) {
      case 1:
        key_pressed(11);
        break;
      case 3:
        key_pressed(12);
        break;
      default:
        stdout.printf("invalid button pressed\n");
        break;
      }
      return true;
    }
  
  
    private bool on_button_release(Gdk.EventButton event) {
      switch(event.button) {
      case 1:
        key_released(11);
        break;
      case 3:
        key_released(12);
        break;
      default:
        stdout.printf("invalid button released\n");
        break;
      }
      return true;
    }
    
    private bool on_key_press(Gdk.EventKey event) {
      if (!pressed[event.keyval]) {
        pressed[event.keyval] = true;
        switch (event.keyval) {
        case Gdk.Key.Up:
          key_pressed(0);
          break;
        case Gdk.Key.Down:
          key_pressed(1);
          break;
        case Gdk.Key.Left:
          key_pressed(2);
          break;
        case Gdk.Key.Right:
          key_pressed(3);
          break;
        case Gdk.Key.w:
          key_pressed(4);
          break;
        case Gdk.Key.a:
          key_pressed(5);
          break;
        case Gdk.Key.s:
          key_pressed(6);
          break;
        case Gdk.Key.d:
          key_pressed(7);
          break;
        case Gdk.Key.f:
          key_pressed(8);
          break;
        case Gdk.Key.g:
          key_pressed(9);
          break;
        case Gdk.Key.space:
          key_pressed(10);
          break;
        default:
          stdout.printf("invalid key pressed\n");
          break;
        }
      }

      return true;
    }
    
    private bool on_key_release(Gdk.EventKey event) {
      pressed[event.keyval] = false;
      switch (event.keyval) {
      case Gdk.Key.Up:
        key_released(0);
        break;
      case Gdk.Key.Down:
        key_released(1);
        break;
      case Gdk.Key.Left:
        key_released(2);
        break;
      case Gdk.Key.Right:
        key_released(3);
        break;
      case Gdk.Key.w:
        key_released(4);
        break;
      case Gdk.Key.a:
        key_released(5);
        break;
      case Gdk.Key.s:
        key_released(6);
        break;
      case Gdk.Key.d:
        key_released(7);
        break;
      case Gdk.Key.f:
        key_released(8);
        break;
      case Gdk.Key.g:
        key_released(9);
        break;
      case Gdk.Key.space:
        key_released(10);
        break;
      default:
        stdout.printf("different key released\n");
        break;
      }
      
      return true;
    }
    
    private void on_file_chosen(FileChooserButton b) {
      int key = -1;
      b.get_title().scanf("Choose a file for key %d", ref key);
      if (key != -1) {
        filenames[key] = b.get_uri();
        pipelines[key] = ElementFactory.make("playbin2", "playbin");
        pipelines[key].set("uri", filenames[key]);
      }
    }
    
    private void key_pressed(int key) {
      if (filenames.has_key(key)) {
        stdout.printf("key pressed: %i, playing uri: %s\n", key, filenames[key]);
        var p = pipelines[key];
        p.set_state(State.PAUSED);
        p.seek_simple(Gst.Format.TIME, Gst.SeekFlags.FLUSH, 0);
        p.set_state(State.PLAYING);
      } else {
        stdout.printf("key pressed: %i, no audio selected\n", key);
      }
    }
    
    private void key_released(int key) {
      stdout.printf("key %d released\n", key);
    }

    public static int main (string[] args) {
      Gtk.init(ref args);
      Gst.init(ref args);

      var app = new Window();
      app.show_all();

      app.destroy.connect(Gtk.main_quit);

      Gtk.main ();
      return 0;
    }

  }
}
