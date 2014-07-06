all:
	valac --pkg gtk+-3.0 --pkg gee-1.0 --pkg gstreamer-0.10 sounds.vala

clean:
	rm sounds *~