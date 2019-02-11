/***
    This file is part of snapcast
    Copyright (C) 2014-2018  Johannes Pohl
    Copyright (C) 2019-2019  Morten Hermanrud

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
***/

#ifndef PULSEAUDIO_STREAM_H
#define PULSEAUDIO_STREAM_H

#include "processStream.h"
#include "watchdog.h"

/**
 * Connects to Pulseaudio server by native API
 * 
 * usage:
 *   snapserver -s "pulse:///pulseaudio?name=Mopidy&username=<my username>&\
 *                  password=<my password>[&devicename=Snapcast][&bitrate=320]\
 *                  [&volume=<volume in percent>][&cache=<cache dir>]"
 */

class PulseaudioStream : public ProcessStream, WatchdogListener
{
public:
	PulseaudioStream(PcmListener* pcmListener, const StreamUri& uri);
	virtual ~PulseaudioStream();

protected:
	std::unique_ptr<Watchdog> watchdog_;

	virtual void stderrReader();
	virtual void onStderrMsg(const char* buffer, size_t n);
	virtual void initExeAndPath(const std::string& filename);

	virtual void onTimeout(const Watchdog* watchdog, size_t ms);
};


#endif

