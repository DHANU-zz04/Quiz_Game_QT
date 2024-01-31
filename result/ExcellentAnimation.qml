/* Quiz
 * Copyright (C) 2020  Sandro Wißmann
 *
 * Quiz is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Quiz is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Quiz If not, see <http://www.gnu.org/licenses/>.
 *
 * Web-Site: https://github.com/SandroWissmann/Quiz
 */
import QtQuick 2.15
import QtQuick.Particles 2.15

ParticleSystem {
    anchors.fill: parent

    ImageParticle {
        groups: ["stars"]
        anchors.fill: parent
        source: "qrc:///ressources/images/star.png"
        alphaVariation: 0.2
        colorVariation: 1.0
    }
    Emitter {
        group: "stars"
        emitRate: 800
        lifeSpan: 2400
        size: 24
        sizeVariation: 8
        anchors.fill: parent
    }
    Turbulence {
        anchors.fill: parent
        strength: 2
    }
}