#ifndef SUPRAVIM_ACHIEVEMENTS_H
#define SUPRAVIM_ACHIEVEMENTS_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>

#ifdef __cplusplus
extern "C" {
#endif

static inline int supravim_ach__inbox(char *out, size_t n) {
	char dir[4096];
	const char *cfg = getenv("XDG_CONFIG_HOME");
	if (cfg && cfg[0]) {
		snprintf(dir, sizeof(dir), "%s/supravim", cfg);
	} else {
		const char *home = getenv("HOME");
		if (!home || !home[0])
			return 0;
		snprintf(dir, sizeof(dir), "%s/.config/supravim", home);
	}
	struct stat st;
	if (stat(dir, &st) != 0 || !S_ISDIR(st.st_mode))
		return 0;
	snprintf(out, n, "%s/achievements.inbox", dir);
	return 1;
}

static inline void supravim_ach__write(const char *line) {
	char path[4096];
	if (!supravim_ach__inbox(path, sizeof(path)))
		return;
	FILE *f = fopen(path, "a");
	if (!f)
		return;
	fputs(line, f);
	fclose(f);
}

static inline void supravim_ach_event(const char *id) {
	if (!id || !id[0])
		return;
	char line[512];
	snprintf(line, sizeof(line), "E %s\n", id);
	supravim_ach__write(line);
}

static inline void supravim_ach_metric(const char *name, long count) {
	if (!name || !name[0])
		return;
	char line[512];
	snprintf(line, sizeof(line), "M %s %ld\n", name, count);
	supravim_ach__write(line);
}

static inline void supravim_ach_lang(const char *filetype) {
	if (!filetype || !filetype[0])
		return;
	char line[512];
	snprintf(line, sizeof(line), "L %s\n", filetype);
	supravim_ach__write(line);
}

#ifdef __cplusplus
}
#endif

#endif
