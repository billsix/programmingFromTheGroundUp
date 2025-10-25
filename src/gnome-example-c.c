#include <gtk/gtk.h>

#define MY_APP_TITLE "Gnome Example Program"
#define MY_APP_ID "org.example.gnome_example"
#define MY_BUTTON_TEXT "I Want to Quit the Example Program"
#define MY_QUIT_QUESTION "Are you sure you want to quit?"

/* Dialog response handler */
static void dialog_response_cb(GtkDialog *dialog, gint response_id,
                               gpointer user_data) {
  GApplication *app = G_APPLICATION(user_data);
  if (response_id == GTK_RESPONSE_YES) {
    g_application_quit(app);
  }
  gtk_window_destroy(GTK_WINDOW(dialog));
}

/* Show modal confirmation dialog */
static void show_quit_dialog(GtkWindow *parent, GApplication *app) {
  GtkWidget *dialog = gtk_dialog_new_with_buttons(
      "Confirm", parent, GTK_DIALOG_MODAL, "_Yes", GTK_RESPONSE_YES, "_No",
      GTK_RESPONSE_NO, NULL);

  GtkWidget *label = gtk_label_new(MY_QUIT_QUESTION);
  gtk_label_set_wrap(GTK_LABEL(label), TRUE);

  GtkWidget *content_area = gtk_dialog_get_content_area(GTK_DIALOG(dialog));
  gtk_box_append(GTK_BOX(content_area), label);

  g_signal_connect(dialog, "response", G_CALLBACK(dialog_response_cb), app);

  gtk_window_present(GTK_WINDOW(dialog));
}

/* Button clicked */
static void on_button_clicked(GtkButton *button, gpointer user_data) {
  GApplication *app = G_APPLICATION(user_data);
  GtkWindow *parent = GTK_WINDOW(gtk_widget_get_root(GTK_WIDGET(button)));
  show_quit_dialog(parent, app);
}

/* Window close request */
static gboolean on_close_request(GtkWindow *window, gpointer user_data) {
  GApplication *app = G_APPLICATION(user_data);
  show_quit_dialog(window, app);
  return TRUE;  // prevent automatic closing
}

/* Application activate */
static void on_activate(GApplication *app, gpointer user_data) {
  GtkWidget *window = gtk_application_window_new(GTK_APPLICATION(app));
  gtk_window_set_title(GTK_WINDOW(window), MY_APP_TITLE);
  gtk_window_set_default_size(GTK_WINDOW(window), 400, 100);

  GtkWidget *button = gtk_button_new_with_label(MY_BUTTON_TEXT);
  gtk_window_set_child(GTK_WINDOW(window), button);

  g_signal_connect(button, "clicked", G_CALLBACK(on_button_clicked), app);
  g_signal_connect(window, "close-request", G_CALLBACK(on_close_request), app);

  gtk_window_present(GTK_WINDOW(window));
}

int main(int argc, char **argv) {
  GtkApplication *app =
      gtk_application_new(MY_APP_ID, G_APPLICATION_FLAGS_NONE);
  g_signal_connect(app, "activate", G_CALLBACK(on_activate), NULL);

  int status = g_application_run(G_APPLICATION(app), argc, argv);
  g_object_unref(app);
  return status;
}
